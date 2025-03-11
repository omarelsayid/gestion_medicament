class Appointment {
  int? id;
  String doctorName;
  String date;
  String time;
  String notes;

  Appointment({
    this.id,
    required this.doctorName,
    required this.date,
    required this.time,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorName': doctorName,
      'date': date,
      'time': time,
      'notes': notes,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      doctorName: map['doctorName'],
      date: map['date'],
      time: map['time'],
      notes: map['notes'],
    );
  }
}
