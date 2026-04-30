
import 'package:eghealthcare/core/shared/model/patient_model.dart';

import '../../domain/entities/patient_entity.dart';


extension Doctorpatientmodel on PatientModel{
  PatientEntity toPatientEntity(){
    return PatientEntity(
      id:patientID,
      name:name,
      age: age,
      image: avatar,
      gender: gender,
      medicalSummary:medicalSummary
    );
  }

}