

import '../../../../../core/shared/model/doctor_model.dart';
import '../../domain/entities/doctor_entity.dart';

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