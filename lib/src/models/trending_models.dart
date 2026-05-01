/// [TimeWindow] defines the time period for trending results.
enum TimeWindow { day, week }

extension TimeWindowExtension on TimeWindow {
  String get value => name;
}
