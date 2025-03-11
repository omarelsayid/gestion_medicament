import 'package:flutter/material.dart';
import '../models/medicine_model.dart';
import '../repositories/medicine_repository.dart';

class MedicineProvider with ChangeNotifier {
  final MedicineRepository _repository = MedicineRepository();
  List<Medicine> _medicines = [];

  List<Medicine> get medicines => _medicines;

  Future<void> loadMedicines() async {
    _medicines = await _repository.getAllMedicines();
    notifyListeners();
  }

  Future<void> addMedicine(Medicine medicine) async {
    await _repository.insertMedicine(medicine);
    await loadMedicines();
  }

  Future<void> updateMedicine(Medicine medicine) async {
    await _repository.updateMedicine(medicine);
    await loadMedicines();
  }

  Future<void> deleteMedicine(int id) async {
    await _repository.deleteMedicine(id);
    await loadMedicines();
  }
}
