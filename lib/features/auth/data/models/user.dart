

import '../../domain/entities/user.dart';

class UserModel {

  String? fullName;
  String? email;
  String? imageURL;
  String? userRole;

  UserModel({this.fullName, this.email, this.imageURL, this.userRole});

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