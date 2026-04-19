
import 'package:eghealthcare/features/Patient/Dashboard/domain/entities/doctor_entity.dart';

import '../../../../../core/shared/model/doctor_model.dart';

extension DoctorModelExtensionToDoctorEntity on DoctorModel{
  DoctorEntity doctorEntity(){
    return DoctorEntity(
      id: doctorID,
      name: name,
      specialty: specialty,
      imageUrl: avatar
    );
  }
}