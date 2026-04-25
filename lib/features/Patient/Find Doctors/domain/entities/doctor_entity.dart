class DoctorEntity {
  final String id;
  final String name;
  final String specialty;
  final String? imageUrl;
  final String? bio;
  final String? experience;

  DoctorEntity({
    required this.name,
    required this.specialty,
    this.imageUrl,
    required this.id,
    this.bio,
    this.experience,
  });
}
