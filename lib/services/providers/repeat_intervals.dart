import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RepeatIntervals {
  static const RepeatInterval daily = RepeatInterval.daily;
  static const RepeatInterval everyMinute = RepeatInterval.everyMinute;
  static const RepeatInterval hourly = RepeatInterval.hourly;
  static const RepeatInterval weekly = RepeatInterval.weekly;

  final String dailyString = 'daily';
  final String everyMinuteString = 'every minute';
  final String hourlyString = 'hourly';
  final String weeklyString = 'weekly';

  getInterval(String value) {
    if (value == dailyString) {
      return daily;
    }
    if (value == everyMinuteString) {
      return everyMinute;
    }
    if (value == hourlyString) {
      return hourly;
    }
    if (value == weeklyString) {
      return weekly;
    }
  }
}
