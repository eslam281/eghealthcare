class AppointmentEntity {
  final int id;
  final String patientName;
  final String? avatar;
  final String type;
  final DateTime date;
  final String status;
  final String time;
  final String patientID;

  AppointmentEntity({
    required this.patientName,
    required this.type,
    required this.date,
    required this.time,
    required this.id,
    required this.avatar,
    required this.status, required this.patientID,
  });
}
