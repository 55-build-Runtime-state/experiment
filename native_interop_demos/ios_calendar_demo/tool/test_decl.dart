import 'package:ios_calendar_demo/eventkit_bindings.dart';
import 'package:objective_c/objective_c.dart' as objc;

void main() {
  final store = EKEventStore();
  final startDate = objc.NSDate.date();
  final endDate = objc.NSDate.dateWithTimeIntervalSinceNow(30.0 * 24 * 60 * 60);
  final predicate = store.predicateForEventsWithStartDate(startDate, endDate: endDate);
  final eventsArray = store.eventsMatchingPredicate(predicate);
  
  final count = eventsArray.count;
  for (int i = 0; i < count; i++) {
    final obj = eventsArray.objectAtIndex(i);
    final event = EKEvent.as(obj);
    final int result = event.startDate.compare(event.endDate).value;
  }
}
