import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '../repositories/appointment_repository.dart';

class AppointmentProvider with ChangeNotifier {
  final AppointmentRepository _repository = AppointmentRepository();
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  Future<void> loadAppointments() async {
    _appointments = await _repository.getAllAppointments();
    notifyListeners();
  }

  Future<void> addAppointment(Appointment appointment) async {
    await _repository.insertAppointment(appointment);
    await loadAppointments();
  }

  Future<void> updateAppointment(Appointment appointment) async {
    await _repository.updateAppointment(appointment);
    await loadAppointments();
  }

  Future<void> deleteAppointment(int id) async {
    await _repository.deleteAppointment(id);
    await loadAppointments();
  }
}
