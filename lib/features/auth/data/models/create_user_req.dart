class CreateUserReq{
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final int age;
  final String address;
  final String userRole;
  final String gender;

  CreateUserReq({required this.fullName, required this.email, required this.password,
    required this.userRole, required this.phoneNumber, required this.age, required this.address, required this.gender});
  Map<String, dynamic> toJson(String uid) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['patientID'] = uid;
    data['name'] = fullName;
    data['age'] = age;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['role'] = userRole;
    data['gender'] = gender;
    return data;
  }
}