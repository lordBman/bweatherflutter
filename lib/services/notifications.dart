import 'package:flutter/services.dart';

class NotificationHelper {
    static const MethodChannel _channel = MethodChannel('com.example/notification');

    static Future<void> showNotification(String title, String message) async {
        try {
          await _channel.invokeMethod('showNotification', {'title': title, 'message': message });
        } catch (e) {
          throw 'Failed to show notification: $e';
        }
    }
}