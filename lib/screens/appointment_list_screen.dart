import 'package:flutter/material.dart';
import 'package:gestion_medicament/providers/appointment_provider.dart';
import 'package:gestion_medicament/screens/add_appointment_screen.dart';
import 'package:gestion_medicament/screens/edit_appointment_screen.dart';
import 'package:provider/provider.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AppointmentProvider>(context, listen: false).loadAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment List'),
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, provider, child) {
          return provider.appointments.isEmpty
              ? const Center(child: Text('No appointments found.'))
              : ListView.builder(
                  itemCount: provider.appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = provider.appointments[index];
                    return ListTile(
                      title: Text(
                        appointment.doctorName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Date: ${appointment.date} - Time: ${appointment.time}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAppointmentScreen(
                                      appointment: appointment),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              _confirmDelete(
                                  context, provider, appointment.id!);
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

  void _confirmDelete(
      BuildContext context, AppointmentProvider provider, int appointmentId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Appointment?'),
        content:
            const Text('Are you sure you want to delete this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteAppointment(appointmentId);
              Navigator.pop(ctx); // Close dialog
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
