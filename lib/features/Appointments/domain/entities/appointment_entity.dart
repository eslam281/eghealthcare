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
}
