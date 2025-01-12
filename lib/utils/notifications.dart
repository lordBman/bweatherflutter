/*import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationManager(): flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin() {
    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    //var scheduledNotificationDateTime = DateTime.now().add(const Duration(seconds: 5));
    const androidPlatformChannelSpecifics = AndroidNotificationDetails('channel_id', 'channel_name', channelDescription:  'channel_description');
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    const platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        'Scheduled Notification',
        'This is a local notification.',
        //scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}*/