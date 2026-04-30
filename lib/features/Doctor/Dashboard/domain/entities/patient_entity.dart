import '../../../../../core/shared/model/patient_model.dart';

class PatientEntity {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String? image;
  final MedicalSummary? medicalSummary;

  const PatientEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.image,
    this.medicalSummary,
  });
}
