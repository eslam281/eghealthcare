
import 'package:eghealthcare/features/Doctor/Dashboard/domain/entities/user_entity.dart';

class DoctorModel {
  late String doctorID;
  late String name;
  late String specialty;
  late int age;
  late String gender;
  late String phoneNumber;
  late String email;
  late String address;
  String? avatar;
  String? experience;
  String? bio;
  String? availability;
  String? reviews;
  String? createdAt;
  String? updatedAt;

  DoctorModel(
      {required this.doctorID,
        required this.name,
        required this.age,
        required this.gender,
        required this.phoneNumber,
        required this.email,
        required this.address,
        this.avatar,
        required this.specialty,
        this.experience,
        this.bio,
        this.availability,
        this.reviews,
        this.createdAt,
        this.updatedAt});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    doctorID = json['doctorID'];
    name = json['name'];
    age = json['age'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    avatar = json['avatar'];
    email = json['email'];
    address = json['address'];
    avatar = json['avatar'];
    specialty = json['specialty'];
    experience = json['experience'];
    bio = json['bio'];
    availability = json['availability'];
    reviews = json['reviews'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorID'] = doctorID;
    data['name'] = name;
    data['age'] = age;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['avatar'] = avatar;
    data['address'] = address;
    data['avatar'] = avatar;
    data['specialty'] = specialty;
    data['experience'] = experience;
    data['bio'] = bio;
    data['availability'] = availability;
    data['reviews'] = reviews;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
extension DoctorModelExtension on DoctorModel{
  UserEntity doctorEntity(){
    return UserEntity(
      fullName: name,
      email: email,
      age: age,
      address: address,
      phoneNumber: phoneNumber,
      imageURL: avatar
    );
  }
}