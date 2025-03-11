import 'package:sqflite/sqflite.dart';
import '../models/appointment_model.dart';
import '../database_helper.dart';

class AppointmentRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertAppointment(Appointment appointment) async {
    Database db = await _databaseHelper.database;
    return await db.insert('appointments', appointment.toMap());
  }

  Future<List<Appointment>> getAllAppointments() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db.query('appointments');
    return List.generate(maps.length, (i) {
      return Appointment.fromMap(maps[i]);
    });
  }

  Future<int> updateAppointment(Appointment appointment) async {
    Database db = await _databaseHelper.database;
    return await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  Future<int> deleteAppointment(int id) async {
    Database db = await _databaseHelper.database;
    return await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
