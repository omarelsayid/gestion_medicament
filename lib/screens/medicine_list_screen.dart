import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/medicine_model.dart';
import '../providers/medicine_provider.dart';
import 'add_medicine_screen.dart';
import 'edit_medicine_screen.dart';

class MedicineListScreen extends StatelessWidget {
   const MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine List'),
      ),
      body: Consumer<MedicineProvider>(
        builder: (context, medicineProvider, child) {
          return ListView.builder(
            itemCount: medicineProvider.medicines.length,
            itemBuilder: (context, index) {
              Medicine medicine = medicineProvider.medicines[index];
              return ListTile(
                title: Text(medicine.name),
                subtitle: Text(
                    'Dosage: ${medicine.dosage} - Frequency: ${medicine.frequency}'),
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
                                EditMedicineScreen(medicine: medicine),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        medicineProvider.deleteMedicine(medicine.id!);
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
            MaterialPageRoute(builder: (context) => AddMedicineScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
