import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appointment_model.dart';
import '../providers/appointment_provider.dart';

class EditAppointmentScreen extends StatelessWidget {
  final Appointment appointment;
  final _formKey = GlobalKey<FormState>();
  final _doctorNameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _notesController = TextEditingController();

  EditAppointmentScreen({super.key, required this.appointment}) {
    _doctorNameController.text = appointment.doctorName;
    _dateController.text = appointment.date;
    _timeController.text = appointment.time;
    _notesController.text = appointment.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le Rendez-vous'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _doctorNameController,
                decoration: InputDecoration(labelText: 'Nom du Docteur'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Heure'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une heure';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(labelText: 'Notes'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer des notes';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Appointment updatedAppointment = Appointment(
                      id: appointment.id,
                      doctorName: _doctorNameController.text,
                      date: _dateController.text,
                      time: _timeController.text,
                      notes: _notesController.text,
                    );
                    Provider.of<AppointmentProvider>(context, listen: false)
                        .updateAppointment(updatedAppointment);
                    Navigator.pop(context);
                  }
                },
                child: Text('Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
