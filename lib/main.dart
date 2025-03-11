import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:gestion_medicament/screens/start_screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'providers/medicine_provider.dart';
import 'providers/appointment_provider.dart';


void main() async {
  if (kIsWeb) {
    // تهيئة sqflite_common_ffi_web لاستخدام FFI في الويب
    databaseFactory = databaseFactoryFfiWeb;
  } else {
    // تهيئة sqflite_common_ffi لاستخدام FFI في الأجهزة المحمولة
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // تشغيل تطبيق Flutter مع Provider
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MedicineProvider()),
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de Médicaments et Rendez-vous',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StartScreen(), // افتح StartScreen كشاشة أولية
      debugShowCheckedModeBanner: false, // إزالة شعار Debug
    );
  }
}
