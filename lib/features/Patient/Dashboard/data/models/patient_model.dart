import '../../../../../core/shared/model/patient_model.dart';
import '../../domain/entities/user_entity.dart';


extension PatientModelX on PatientModel{
  UserEntity toPatientEntity(){
    return UserEntity(
      fullName: name,
      email: email,
      age: age,
      address: address,
      phoneNumber: phoneNumber,
      imageURL: avatar,
      id: patientID
    );
  }
}
