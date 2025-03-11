import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appointment_model.dart';
import '../providers/appointment_provider.dart';
import 'add_appointment_screen.dart';
import 'edit_appointment_screen.dart';

class AppointmentListScreen extends StatelessWidget {
  // إزالة const من المُنشئ
  AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment List'),
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          return ListView.builder(
            itemCount: appointmentProvider.appointments.length,
            itemBuilder: (context, index) {
              Appointment appointment = appointmentProvider.appointments[index];
              return ListTile(
                title: Text(appointment.doctorName),
                subtitle: Text(
                    'Date: ${appointment.date} - Time: ${appointment.time}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditAppointmentScreen(appointment: appointment),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        appointmentProvider.deleteAppointment(appointment.id!);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAppointmentScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
