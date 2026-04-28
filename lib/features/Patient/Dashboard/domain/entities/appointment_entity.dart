class AppointmentEntity {
  final int id;
  final String doctorName;
  final String type;
  final DateTime date;
  final String time;
  final String? avatar;

  AppointmentEntity({
    required this.doctorName,
    required this.type,
    required this.date,
    required this.time,
    required this.id,
    required this.avatar,
  });
}
