import '../../domain/entities/user_entity.dart';

class PatientModel {
  late String patientID;
  late String name;
  late int age;
  late String gender;
  late String phoneNumber;
  late String email;
  late String address;
  String? avatar;
  String? medicalHistory;
  String? medicalSummary;
  String? patientStats;
  String? currentCondition;
  String? medications;
  String? createdAt;
  String? updatedAt;

  PatientModel(
      {required this.patientID,
        required this.name,
        required this.age,
        required this.gender,
        required this.phoneNumber,
        required this.email,
        required this.address,
        this.avatar,
        this.medicalHistory,
        this.medicalSummary,
        this.patientStats,
        this.currentCondition,
        this.medications,
        this.createdAt,
        this.updatedAt});

  PatientModel.fromJson(Map<String, dynamic> json) {
    patientID = json['patientID'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    avatar = json['avatar'];
    email = json['email'];
    address = json['address'];
    medicalHistory = json['medicalHistory'];
    medicalSummary = json['medicalSummary'];
    patientStats = json['patientStats'];
    currentCondition = json['currentCondition'];
    medications = json['medications'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientID'] = patientID;
    data['name'] = name;
    data['age'] = age;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['avatar'] = avatar;
    data['address'] = address;
    data['medicalHistory'] = medicalHistory;
    data['medicalSummary'] = medicalSummary;
    data['patientStats'] = patientStats;
    data['currentCondition'] = currentCondition;
    data['medications'] = medications;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
extension PatientModelX on PatientModel{
  UserEntity toPatientEntity(){
    return UserEntity(
      fullName: name,
      email: email,
      age: age,
      address: address,
      phoneNumber: phoneNumber,
      imageURL: avatar,
    );
  }
}
