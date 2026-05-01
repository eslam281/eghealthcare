
import 'package:eghealthcare/features/Doctor/Dashboard/domain/entities/user_entity.dart';

import '../../../../../core/shared/model/doctor_model.dart';


extension DoctorModelExtensionToUserEntity on DoctorModel{
  UserEntity toUserEntity(){
    return UserEntity(
        id: doctorID,
      fullName: name,
      email: email,
      age: age,
      address: address,
      phoneNumber: phoneNumber,
      imageURL: avatar
    );
  }
}