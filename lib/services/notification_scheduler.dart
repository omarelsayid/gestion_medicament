
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import "package:timezone/timezone.dart" as tz;
import 'package:flutter/material.dart';

class NotificationScheduler {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Call this in main() before runApp()
  static Future<void> initializeNotifications() async {
    // Initialize timezones
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Casablanca')); // or your desired location

    // Android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Platform settings
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    // Initialize the plugin
    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    // Convert to timezone-aware datetime
    final tz.TZDateTime tzScheduledTime = tz.TZDateTime.local(
      scheduledTime.year,
      scheduledTime.month,
      scheduledTime.day,
      scheduledTime.hour,
      scheduledTime.minute,
      scheduledTime.second,
    );

    // Avoid scheduling in the past
    if (tzScheduledTime.isBefore(tz.TZDateTime.now(tz.local))) {
      debugPrint("Cannot schedule notification in the past.");
      return;
    }

    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'medicaments_channel_id', // Channel ID
          'Medicaments Notifications', // Channel name
          channelDescription: 'Notification pour rappel de médicament',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time, // Only if repeating daily at same time
    );
  }

  /// Optional: Cancel a specific notification
  static Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// Optional: Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
