import 'package:eghealthcare/core/shared/model/patient_model.dart';
import 'package:eghealthcare/features/Patient/profile/domain/entities/patientProfile_entities.dart';

extension PatientProfileModel on PatientModel {
  PatientProfileEntities toPatientProfileEntities() {
    return PatientProfileEntities(
      id: patientID,
      name: name,
      avatar: avatar,
      age: age,
      gender: gender,
      medicalSummary: medicalSummary,
      medicalHistory: medicalHistory,
      patientStats: patientStats,
    );
  }
}
