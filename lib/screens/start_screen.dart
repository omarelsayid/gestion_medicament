import 'package:flutter/material.dart';
import 'home_screen.dart'; // استيراد شاشة HomeScreen

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to My Reminder',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40), // مسافة بين النص والأزرار
            ElevatedButton(
              onPressed: () {
                // الانتقال إلى شاشة HomeScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text(' start now'),
            ),
            const SizedBox(height: 20), // مسافة بين الزرين
            TextButton(
              onPressed: () {
                // يمكنك إضافة وظيفة إضافية هنا
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('ميزة قريبًا!')),
                );
              },
              child: const Text('Learn More'),
            ),
          ],
        ),
      ),
    );
  }
}