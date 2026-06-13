import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CalendarHomePage());
  }
}

class CalendarHomePage extends StatefulWidget {
  const CalendarHomePage({super.key});

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  bool _hasCalendarPermission = false;
  List<String> _events = [];

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.calendarFullAccess.status;
    setState(() {
      _hasCalendarPermission = status.isGranted;
    });
  }

  Future<void> _requestPermission() async {
    await Permission.calendarFullAccess
        .onGrantedCallback(() {
          debugPrint('Granted');
          setState(() {
            _hasCalendarPermission = true;
          });
        })
        .onDeniedCallback(() {
          debugPrint('denied');
        })
        .request();
  }

  void _createEvent() {
    setState(() {
      _events.add('Sample Event ${_events.length + 1}');
    });
  }

  void _retrieveEvents() {
    setState(() {
      _events = [
        'Team Meeting - 10:00 AM',
        'Lunch with Client - 12:30 PM',
        'Project Review - 3:00 PM',
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendar Permission Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _hasCalendarPermission ? null : _requestPermission,
              child: Text(
                _hasCalendarPermission
                    ? 'Calendar Access Granted'
                    : 'Request Calendar Permission',
              ),
            ),
            const Divider(height: 32),
            ElevatedButton(
              onPressed: _hasCalendarPermission ? _createEvent : null,
              child: const Text('Create Event'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _hasCalendarPermission ? _retrieveEvents : null,
              child: const Text('Retrieve Events'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Events',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _events.isEmpty
                  ? const Center(child: Text('No events to display.'))
                  : SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Event Details')),
                        ],
                        rows: _events
                            .map(
                              (event) =>
                                  DataRow(cells: [DataCell(Text(event))]),
                            )
                            .toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
