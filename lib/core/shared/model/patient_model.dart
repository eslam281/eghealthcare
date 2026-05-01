
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
  MedicalSummary? medicalSummary;
  PatientStats? patientStats;
  String? currentCondition;
  String? medications;
  DateTime? createdAt;
  DateTime? updatedAt;

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
    medicalSummary = json['medicalSummary'] != null
        ? MedicalSummary.fromJson(json['medicalSummary'])
        : null;

    patientStats = json['patientStats'] != null
        ? PatientStats.fromJson(json['patientStats'])
        : null;

    currentCondition = json['currentCondition'];
    medications = json['medications'];
    createdAt =  DateTime.parse(json['createdAt']);
    updatedAt =  DateTime.parse(json['updatedAt']);
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
    data['medicalSummary'] = medicalSummary?.toJson();
    data['patientStats'] = patientStats?.toJson();
    data['currentCondition'] = currentCondition;
    data['medications'] = medications;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    return data;
  }
}
class MedicalSummary {
  String? bloodType;
  String? allergies;
  String? lastVisit;
  String? nextAppointment;

  MedicalSummary(
      {this.bloodType, this.allergies, this.lastVisit, this.nextAppointment});

  MedicalSummary.fromJson(Map<String, dynamic> json) {
    bloodType = json['bloodType'];
    allergies = json['allergies'];
    lastVisit = json['lastVisit'];
    nextAppointment = json['nextAppointment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bloodType'] = bloodType;
    data['allergies'] = allergies;
    data['lastVisit'] = lastVisit;
    data['nextAppointment'] = nextAppointment;
    return data;
  }
}

class PatientStats {
  int? totalVisits;
  int? completed;
  int? upcoming;

  PatientStats({this.totalVisits, this.completed, this.upcoming});

  PatientStats.fromJson(Map<String, dynamic> json) {
    totalVisits = json['totalVisits'];
    completed = json['completed'];
    upcoming = json['upcoming'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalVisits'] = totalVisits;
    data['completed'] = completed;
    data['upcoming'] = upcoming;
    return data;
  }
}
