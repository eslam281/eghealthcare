

import '../../domain/entities/user.dart';

class UserModel {

  String? fullName;
  String? email;
  String? imageURL;

  UserModel({this.fullName, this.email, this.imageURL});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName= json['name'];
    email= json['email'];
  }
}
extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
        fullName: fullName,
        email: email,
        imageURL: imageURL
    );

  }
}