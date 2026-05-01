import '../../../../../core/shared/model/patient_model.dart';

class PatientProfileEntities {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String? avatar;
  MedicalSummary? medicalSummary;
  String? medicalHistory;
  PatientStats? patientStats;

  PatientProfileEntities({
    required this.name,
    this.avatar,
    this.medicalSummary,
    this.medicalHistory,
    this.patientStats,
    required this.id,
    required this.age,
    required this.gender,
  });
}
