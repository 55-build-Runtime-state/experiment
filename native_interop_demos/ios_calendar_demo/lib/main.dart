import 'package:flutter/material.dart';
import 'package:objective_c/objective_c.dart';
import 'package:permission_handler/permission_handler.dart';

import 'eventkit_bindings.dart';

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
  late final EKEventStore _eventStore;

  @override
  void initState() {
    super.initState();
    _eventStore = EKEventStore();
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
    final startDate = NSDate.date();
    final endDate = NSDate.dateWithTimeIntervalSinceNow(30.0 * 24 * 60 * 60);

    final calendars = _eventStore.calendars;
    debugPrint(calendars.toString());
    final predicate = _eventStore.predicateForEventsWithStartDate(
      startDate,
      endDate: endDate,
    );

    final NSArray eventsArray = _eventStore.eventsMatchingPredicate(predicate);

    final count = eventsArray.count;
    List<EKEvent> fetchedEvents = [];
    for (int i = 0; i < count; i++) {
      final obj = eventsArray.objectAtIndex(i);
      final event = EKEvent.as(obj);
      debugPrint(event.title.toDartString());
      fetchedEvents.add(event);
    }

    fetchedEvents.sort((a, b) {
      return a.startDate.compare(b.startDate).value;
    });

    setState(() {
      _events = fetchedEvents.map((e) {
        return e.title.toDartString();
      }).toList();
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
