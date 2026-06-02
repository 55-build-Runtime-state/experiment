import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:genui_workshop/message_bubble.dart';
import 'package:genui_workshop/genui_utils.dart';
import 'package:genui_workshop/tool_calls.dart';
import 'firebase_options.dart';
import 'package:genui/genui.dart' hide TextPart;
import 'package:genui/genui.dart' as genui;
import 'catalog/weather_input.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just Today',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ConversationItem> _items = [];
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  late final ChatSession _chatSession;

  // Add GenUI controllers
  late final SurfaceController _controller;
  late final A2uiTransportAdapter _transport;
  late final Conversation _conversation;
  late final Catalog catalog;

  @override
  void initState() {
    super.initState();
    final model = FirebaseAI.googleAI().generativeModel(
      //model: 'gemini-3.5-flash',
      model: 'gemini-3.1-flash-lite',
      // tools that will call cloud functions
      tools: [
        Tool.functionDeclarations([fetchWeatherGeocodeTool]),
      ],
    );
    _chatSession = model.startChat();

    // Initialize the GenUI Catalog.
    // The genui package provides a default set of primitive widgets (like text
    // and basic buttons) out of the box using this class.
    //catalog = BasicCatalogItems.asCatalog();
    catalog = BasicCatalogItems.asCatalog().copyWith(newItems: [weatherInput]);

    // Create a SurfaceController to manage the state of generated surfaces.
    _controller = SurfaceController(catalogs: [catalog]);

    // Create a transport adapter that will process messages to and from the
    // agent, looking for A2UI messages.
    _transport = A2uiTransportAdapter(onSend: _sendAndReceive);

    // Link the transport and SurfaceController together in a Conversation,
    // which provides your app a unified API for interacting with the agent.
    _conversation = Conversation(
      controller: _controller,
      transport: _transport,
    );

    // Listen to GenUI stream events to update the UI
    _conversation.events.listen((event) {
      setState(() {
        switch (event) {
          case ConversationSurfaceAdded added:
            _items.add(SurfaceItem(surfaceId: added.surfaceId));
            _scrollToBottom();
          case ConversationSurfaceRemoved removed:
            _items.removeWhere(
              (item) =>
                  item is SurfaceItem && item.surfaceId == removed.surfaceId,
            );
          case ConversationContentReceived content:
            _items.add(TextItem(text: content.text, isUser: false));
            _scrollToBottom();
          case ConversationError error:
            debugPrint('GenUI Error: ${error.error}');
          default:
        }
      });
    });

    // Create the system prompt for the agent, which will include this app's
    // system instruction as well as the schema for the catalog.
    final promptBuilder = PromptBuilder.chat(
      catalog: catalog,
      systemPromptFragments: [systemInstruction],
    );

    // Send the prompt into the Conversation, which will subsequently route it
    // to Firebase using the transport mechanism.
    _conversation.sendRequest(
      ChatMessage.system(promptBuilder.systemPromptJoined()),
    );
  }

  Future<void> _sendAndReceive(ChatMessage msg) async {
    final buffer = StringBuffer();
    Map<String, Object?>? userInputData;
    // Reconstruct the message part fragments
    for (final part in msg.parts) {
      if (part.isUiInteractionPart) {
        // Process the event
        var actionJson =
            jsonDecode(part.asUiInteractionPart!.interaction)
                as Map<String, Object?>;
        var action = actionJson["action"] as Map<String, Object?>;
        var surfaceId = action["surfaceId"] as String;
        userInputData = action;
      } else if (part is genui.TextPart) {
        buffer.write(part.text);
      }
    }

    final text = buffer.toString();

    // Send the string to Firebase AI Logic.
    var response;
    if (userInputData != null) {
      response = await _chatSession.sendMessage(
        Content.text(userInputData['context'].toString()),
      );

      final func = response.functionCalls?.first;
      print(response.functionCalls?.first?.name);
      print(response.functionCalls?.first?.args);
      print(response.text);

      // Call the Dart function.
      // Get the location from the func call
      final params = func.args;
      final uri = Uri.parse(
        fetchWeatherGeocodeUrl + "?location=${params['location']}",
      );
      final funcResponse = await http.get(uri);
      print(funcResponse.body);

      final jsonMap = jsonDecode(funcResponse.body);
      //_transport.addChunk(funcResponse.body);
      response = await _chatSession.sendMessage(
        Content.functionResponse(func.name, jsonMap),
      );
    } else {
      response = await _chatSession.sendMessage(Content.text(text));
    }
    if (response?.text?.isNotEmpty ?? false) {
      // Feed the response back into GenUI's transportation layer
      _transport.addChunk(response.text!);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _addMessage() async {
    final text = _textController.text;

    if (text.trim().isEmpty) {
      return;
    }

    _textController.clear();

    setState(() {
      _items.add(TextItem(text: text, isUser: true));
    });

    _scrollToBottom();

    // Send the user's input through GenUI instead of directly to Firebase.
    await _conversation.sendRequest(ChatMessage.user(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Weather'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              children: [
                for (final item in _items)
                  switch (item) {
                    TextItem() => MessageBubble(
                      text: item.text,
                      isUser: item.isUser,
                    ),
                    // New!
                    SurfaceItem() => Surface(
                      surfaceContext: _controller.contextFor(item.surfaceId),
                    ),
                  },
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      onSubmitted: (_) => _addMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Enter a message',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addMessage,
                    child: const Text('Send'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
