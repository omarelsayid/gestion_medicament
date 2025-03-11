import 'package:flutter/material.dart';
import 'medicine_list_screen.dart';
import 'appointment_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reminder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // نركز العناصر في الوسط
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicineListScreen()),
                );
              },
              icon: Icon(Icons.medication), // أيقونة الأدوية
              label: Text('Gérer les Médicaments'),
            ),
            SizedBox(height: 20), // مسافة بين الزرين
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AppointmentListScreen()), // ننتقل لشاشة المواعيد
                );
              },
              child: Text('Gérer les Rendez-vous'), // نص الزر
            ),
          ],
        ),
      ),
    );
  }
}
