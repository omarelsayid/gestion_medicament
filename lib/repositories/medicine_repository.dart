import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';
import '../models/medicine_model.dart';


class MedicineRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertMedicine(Medicine medicine) async {
    Database db = await _databaseHelper.database;
    return await db.insert('medicines', medicine.toMap());
  }

  Future<List<Medicine>> getAllMedicines() async {
    Database db = await _databaseHelper.database;
    List<Map<String, dynamic>> maps = await db.query('medicines');
    return List.generate(maps.length, (i) {
      return Medicine.fromMap(maps[i]);
    });
  }

  Future<int> updateMedicine(Medicine medicine) async {
    Database db = await _databaseHelper.database;
    return await db.update(
      'medicines',
      medicine.toMap(),
      where: 'id = ?',
      whereArgs: [medicine.id],
    );
  }

  Future<int> deleteMedicine(int id) async {
    Database db = await _databaseHelper.database;
    return await db.delete(
      'medicines',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
