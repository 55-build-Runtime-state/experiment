import 'package:flutter/material.dart';
import 'package:objective_c/objective_c.dart';

import 'eventkit_bindings.dart';

class CreateEventDialog extends StatefulWidget {
  final EKEventStore eventStore;
  final VoidCallback onEventCreated;

  const CreateEventDialog({
    super.key,
    required this.eventStore,
    required this.onEventCreated,
  });

  @override
  State<CreateEventDialog> createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(hours: 1));

  Future<void> _selectDateTime(BuildContext context, bool isStart) async {
    final initialDate = isStart ? _startDate : _endDate;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;

    if (!context.mounted) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );
    if (pickedTime == null) return;

    final finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      if (isStart) {
        _startDate = finalDateTime;
        if (_endDate.isBefore(_startDate)) {
          _endDate = _startDate.add(const Duration(hours: 1));
        }
      } else {
        _endDate = finalDateTime;
      }
    });
  }

  void _saveEvent() {
    final event = EKEvent.eventWithEventStore(widget.eventStore);
    event.title = _titleController.text.toNSString();
    event.notes = _notesController.text.toNSString();
    event.startDate = _startDate.toNSDate();
    event.endDate = _endDate.toNSDate();

    final defaultCalendar = widget.eventStore.defaultCalendarForNewEvents;
    if (defaultCalendar != null) {
      event.calendar = defaultCalendar;
      final success = widget.eventStore.saveEvent(
        event,
        span: EKSpan.EKSpanThisEvent,
        commit: true,
      );
      if (success) {
        widget.onEventCreated();
      } else {
        debugPrint('Failed to save event');
      }
    } else {
      debugPrint('No default calendar found');
    }

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Event'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Start Date'),
              subtitle: Text('${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')} ${_startDate.hour.toString().padLeft(2, '0')}:${_startDate.minute.toString().padLeft(2, '0')}'),
              onTap: () => _selectDateTime(context, true),
              trailing: const Icon(Icons.calendar_today),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('End Date'),
              subtitle: Text('${_endDate.year}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.day.toString().padLeft(2, '0')} ${_endDate.hour.toString().padLeft(2, '0')}:${_endDate.minute.toString().padLeft(2, '0')}'),
              onTap: () => _selectDateTime(context, false),
              trailing: const Icon(Icons.calendar_today),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveEvent,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
