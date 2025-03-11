import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/medicine_provider.dart';
import 'add_medicine_screen.dart';
import 'edit_medicine_screen.dart';

class MedicineListScreen extends StatefulWidget {
  const MedicineListScreen({super.key});

  @override
  State<MedicineListScreen> createState() => _MedicineListScreenState();
}

class _MedicineListScreenState extends State<MedicineListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MedicineProvider>(context, listen: false).loadMedicines());
  }

  @override
  Widget build(BuildContext context) {
    final medicineProvider = Provider.of<MedicineProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Medicine List')),
      body: medicineProvider.medicines.isEmpty
          ? const Center(child: Text('No medicines found.'))
          : ListView.builder(
        itemCount: medicineProvider.medicines.length,
        itemBuilder: (context, index) {
          final medicine = medicineProvider.medicines[index];
          return ListTile(
            title: Text(medicine.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dosage: ${medicine.dosage}'),
                Text('Frequency: ${medicine.frequency}'),
                Text('End Date: ${medicine.endDate}', style: const TextStyle(color: Colors.red)),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditMedicineScreen(medicine: medicine),
                      ),
                    ).then((_) => medicineProvider.loadMedicines()); // Refresh after edit
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.black),
                  onPressed: () {
                    _confirmDelete(context, medicineProvider, medicine.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddMedicineScreen()));
          medicineProvider.loadMedicines(); // Refresh list after adding
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, MedicineProvider provider, int? medicineId) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Medicine?'),
        content: const Text('Are you sure you want to delete this medicine?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteMedicine(medicineId!);
              Navigator.pop(ctx); // Close dialog
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}