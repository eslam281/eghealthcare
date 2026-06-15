import '../../../../../core/shared/model/doctor_model.dart';

class DoctorEntity {
  final String id;
  final String name;
  final String? specialty;
  final String? imageUrl;
  final String? bio;
  final String? experience;
  List<Availability>? availability;

  DoctorEntity({
    required this.name,
    this.specialty,
    this.imageUrl,
    required this.id,
    this.availability,
    this.bio,
    this.experience,
  });
}
