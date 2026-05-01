import '../../../../../core/shared/model/doctor_model.dart';

class DoctorEntity {
  final String id;
  final String name;
  final String specialty;
  final String? avatar;
  final String? experience;
  final String? bio;
  final List<Availability>? availability;
  final List<Review>? reviews;

  DoctorEntity({
    required this.name,
    required this.specialty,
    this.avatar,
    required this.id,
    this.experience,
    this.bio,
    this.availability,
    this.reviews,
  });
}
