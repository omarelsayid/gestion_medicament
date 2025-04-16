import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'local_notifications.dart';

@pragma('vm:entry-point')
class BackgroundService {
  static Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
        autoStart: true,
        onStart: onStart,
        isForegroundMode: false,
        autoStartOnBoot: true,
      ),
    );
  }

  static void startBackgroundService() {
    FlutterBackgroundService().startService();
  }

  static void stopBackgroundService() {
    FlutterBackgroundService().invoke("stopService");
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    WidgetsFlutterBinding.ensureInitialized();
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.setAsForegroundService();
      service.setForegroundNotificationInfo(
        title: "تشغيل في الخلفية",
        content: "تطبيق إدارة الأدوية يعمل الآن في الخلفية",
      );
    }

    await NotificationHelper.initialize(); // تهيئة الإشعارات

    service.on("stopService").listen((event) {
      service.stopSelf();
    });

    Timer.periodic(const Duration(minutes: 5), (timer) async {
      debugPrint("⏳ خدمة الخلفية تعمل...");
    });
  }
}
