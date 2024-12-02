import 'package:flutter/services.dart';

class PlatformChannel {
  static const platform = MethodChannel('com.example.task_manager/messages');

  static Future<void> showToast(String message) async {
    try {
      await platform.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (e) {
      print("Failed to show toast: ${e.message}");
    }
  }
}
