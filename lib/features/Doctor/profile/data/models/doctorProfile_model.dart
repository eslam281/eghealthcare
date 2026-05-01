
import 'package:eghealthcare/core/shared/model/doctor_model.dart';

import '../../domain/entities/doctor_entity.dart';


extension DoctorProfileModel on DoctorModel{
  DoctorEntity toDoctorProfileEntity(){
    return DoctorEntity(
      name: name,
      id: doctorID,
      avatar: avatar,
      specialty: specialty,
      experience: experience,
      bio: bio,
      availability: availability,
      reviews: reviews
    );
  }
}