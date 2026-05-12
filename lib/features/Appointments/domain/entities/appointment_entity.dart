class AppointmentEntity {
  final int id;
  final String name;
  final String type;
  final DateTime date;
  final String time;
  final String? avtar;
  final String status;
  final String doctorID;
  final String patientID;

  AppointmentEntity({
    required this.name,
    required this.type,
    required this.date,
    required this.time,
    required this.id,
    this.avtar,
    required this.doctorID,
    required this.patientID,
    required this.status,
  });

  AppointmentEntity copyWith({
    int? id,
    String? name,
    String? type,
    DateTime? date,
    String? time,
    String? avtar,
    String? status,
    String? doctorID,
    String? patientID,
  }) {
    return AppointmentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      date: date ?? this.date,
      time: time ?? this.time,
      avtar: avtar ?? this.avtar,
      status: status ?? this.status,
      doctorID: doctorID ?? this.doctorID,
      patientID: patientID ?? this.patientID,
    );
  }
}
