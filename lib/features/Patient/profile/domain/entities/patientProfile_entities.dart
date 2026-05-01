class PatientProfileEntities {
  final String id;
  final String name;
  final String? avatar;

  PatientProfileEntities({
    required this.name,
    this.avatar,
    required this.id,
  });
}
