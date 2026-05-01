class UserEntity{
  String id;
  String fullName;
  int age;
  String phoneNumber;
  String email;
  String address;
  String? imageURL;
  UserEntity({
    required this.id,
    required this.fullName,
    required this.age,
    required this.phoneNumber,
    required this.address,
    required this.email,
    this.imageURL
  });
}