class DoctorEntity {
  final String id;
  final String name;
  final String specialty;
  final String? avatar;
  final String? experience;
  final String? bio;

  DoctorEntity({
    required this.name,
    required this.specialty,
    this.avatar,
    required this.id, this.experience, this.bio,
  });
}
