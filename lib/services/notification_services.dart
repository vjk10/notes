import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:notes/android/data/data.dart';

class NotificationService {
  initialize() async {
    AwesomeNotifications().initialize(
      'resource://drawable/ic_notification',
      [
        NotificationChannel(
          defaultColor: const Color(0xFF1F1D2C),
          channelKey: 'reminderServicesKey',
          channelName: 'Reminder Services Channel',
          channelDescription:
              'Notification channel for recurring notifications',
          playSound: true,
          enableVibration: true,
          importance: NotificationImportance.Default,
        ),
        // NotificationChannel(
        //     defaultColor: const Color(0xFF7DA4FF),
        //     channelKey: 'SummaryKey',
        //     channelName: 'Summary Channel',
        //     channelDescription:
        //         'Notification channel for reminder for summary',
        //     playSound: true,
        //     enableVibration: true,
        //     importance: NotificationImportance.Default)
      ],
      debug: false,
    );
  }

  startReminder(String title, int messageID, int duration, bool repeat) async {
    String _timeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    await AwesomeNotifications().createNotification(
      schedule: NotificationInterval(
        timeZone: _timeZone,
        interval: duration,
        repeats: repeat,
        allowWhileIdle: true,
        preciseAlarm: true,
      ),
      content: NotificationContent(
        id: messageID,
        channelKey: 'reminderServicesKey',
        title: title,
        color: c.primary,
        backgroundColor: c.primary,
        category: NotificationCategory.Reminder,
        wakeUpScreen: true,
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }

  endReminder(String messageID) async {
    if (kDebugMode) {
      print("Schedule Cancelled");
    }
    await AwesomeNotifications().cancelSchedule(
      int.parse(messageID),
    );
  }
}
