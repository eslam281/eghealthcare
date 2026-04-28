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
  List<Availability>? availability;
  List<Review>? reviews;
  DateTime? createdAt;
  DateTime? updatedAt;

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
    if (json['availability'] != null) {
      availability = (json['availability'] as List)
          .map((e) => Availability.fromJson(e))
          .toList();
    }

    if (json['reviews'] != null) {
      reviews = (json['reviews'] as List)
          .map((e) => Review.fromJson(e))
          .toList();
    }
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
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
    if (availability != null) {
      data['availability'] =
          availability!.map((e) => e.toJson()).toList();
    }

    if (reviews != null) {
      data['reviews'] =
          reviews!.map((e) => e.toJson()).toList();
    }
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    return data;
  }
}
class Availability {
  late String day;
  late String from;
  late String to;

  Availability({required this.day, required this.from, required this.to});

  Availability.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
class Review {
  late String id;
  late String patientId;
  late String patientName;
  late int rating;
  late String comment;
  late String date;

  Review(
      {required this.id,
        required this.patientId,
        required this.patientName,
        required this.rating,
        required this.comment,
        required this.date});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patientId'];
    patientName = json['patientName'];
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['patientId'] = patientId;
    data['patientName'] = patientName;
    data['rating'] = rating;
    data['comment'] = comment;
    data['date'] = date;
    return data;
  }
}
