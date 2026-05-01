class UserEntity{
 final String fullName;
 final  String id;
 final int age;
 final String phoneNumber;
 final String email;
 final String address;
 final String? imageURL;
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