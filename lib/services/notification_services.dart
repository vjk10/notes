// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:locally/locally.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:notes/services/imports.dart';
import 'package:timezone/timezone.dart';

class NotificationService {
  initialize() async {
    var androidInitializationSettings = const AndroidInitializationSettings(
      'drawable/ic_notification',
    );
    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
    tz.initializeTimeZones();
    currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    if (kDebugMode) {
      print("CURRENT TIMEZONE: " + currentTimeZone);
    }
  }

  createNotificationId(String id, DateTime time) {
    int returnId = int.parse(
      time.hour.toString() + time.minute.toString() + time.second.toString(),
    );
    if (kDebugMode) {
      print("CREATED NOTIFICATION ID: " + returnId.toString());
    }
    return returnId;
  }

  showNotification(
    BuildContext context,
    String id,
    String title,
    String message,
    String messageTime,
    String messageSnackbar,
    DateTime time,
  ) async {
    var android = const AndroidNotificationDetails(
      'reminderServicesKey',
      'Reminders',
      channelDescription: 'Notification channel for reminders',
    );

    int notificationId = createNotificationId(id, time);
    String finalNotificationBody = "";
    var iOS = const IOSNotificationDetails();
    Location location = tz.getLocation(currentTimeZone);
    var notificationTime = tz.TZDateTime.from(time, location);
    var platform = NotificationDetails(
      android: android,
      iOS: iOS,
    );
    if (kDebugMode) {
      print("NOTIFICATION TIME: " + notificationTime.toString());
    }
    if (message.isEmpty) {
      finalNotificationBody = messageTime;
    } else {
      finalNotificationBody = message;
    }
    try {
      await FlutterLocalNotificationsPlugin()
          .zonedSchedule(
        notificationId,
        title,
        finalNotificationBody,
        notificationTime,
        platform,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        payload: id.toString(),
      )
          .then((value) {
        Get.showSnackbar(
          GetSnackBar(
            shouldIconPulse: false,
            backgroundColor: c.surface,
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            borderRadius: 10,
            icon: Icon(
              Icons.schedule_outlined,
              color: c.primary,
            ),
            duration: const Duration(seconds: 2),
            messageText: Text(
              messageSnackbar,
              style: t.textTheme.caption?.copyWith(color: c.onSurface),
            ),
          ),
        );
      });
    } catch (e) {
      if (kDebugMode) {
        print("Must be a date in the future");
      }
      Get.showSnackbar(
        GetSnackBar(
          shouldIconPulse: false,
          backgroundColor: c.surface,
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          borderRadius: 10,
          icon: Icon(
            Icons.priority_high_outlined,
            color: c.error,
          ),
          duration: const Duration(seconds: 2),
          messageText: Text(
            "Must be a date in the future",
            style: t.textTheme.caption?.copyWith(color: c.onSurface),
          ),
        ),
      );
    }
  }

  showAlert(
    BuildContext context,
    String id,
    String title,
    String message,
    String messageTime,
    String messageSnackbar,
    DateTime time,
  ) async {
    var android = const AndroidNotificationDetails(
      'reminderServicesKey',
      'Reminders',
      channelDescription: 'Notification channel for reminders',
    );
    int notificationId = createNotificationId(id, time);
    String finalNotificationBody = "";
    var iOS = const IOSNotificationDetails();
    RepeatInterval repeatInterval = RepeatInterval.daily;
    NotificationDetails notificationDetails = NotificationDetails(
      android: android,
      iOS: iOS,
    );
    await FlutterLocalNotificationsPlugin().periodicallyShow(
      notificationId,
      title,
      finalNotificationBody,
      repeatInterval,
      notificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  endReminder(String messageID) async {
    if (kDebugMode) {
      print("Schedule Cancelled");
    }
  }
}