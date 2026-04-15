
import 'package:eghealthcare/features/Patient/Dashboard/domain/entities/doctor_entity.dart';

class DoctorModel {
  late String doctorID;
  late String name;
  String? avatar;
  late String specialty;
  String? experience;
  String? bio;
  String? availability;
  String? reviews;
  String? createdAt;
  String? updatedAt;

  DoctorModel(
      {required this.doctorID,
        required this.name,
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
  DoctorEntity doctorEntity(){
    return DoctorEntity(
      id: doctorID,
      name: name,
      specialty: specialty,
      imageUrl: avatar
    );
  }
}