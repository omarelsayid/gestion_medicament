class Medicine {
  int? id;
  String name;
  String dosage;
  String frequency;
  String startDate;
  String endDate;

  Medicine({
    this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'],
      name: map['name'],
      dosage: map['dosage'],
      frequency: map['frequency'],
      startDate: map['startDate'],
      endDate: map['endDate'],
    );
  }
}
