class DoctorEntity {
  final int id;
  final String name;
  final String specialty;
  final String? imageUrl;

  DoctorEntity({
    required this.name,
    required this.specialty,
    this.imageUrl,
    required this.id,
  });
}
