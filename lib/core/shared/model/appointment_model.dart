import 'package:eghealthcare/core/shared/model/doctor_model.dart';
import 'package:eghealthcare/core/shared/model/patient_model.dart';

class AppointmentModel {
  late  int appointmentID;
  late  DoctorModel doctor;
  late PatientModel patient;
  late String type;
  late DateTime date;
  late String time;
  late String status;
  late DateTime createdAt;
  late DateTime updatedAt;

  AppointmentModel(
      {required this.appointmentID,
        required this.doctor,
        required this.patient,
        required this.date,
        required this.time,
        required this.type,
        required this.status,
        required this.createdAt,
        required this.updatedAt});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    appointmentID = json['appointmentID'];
    doctor = DoctorModel.fromJson(json['doctor']);
    patient = PatientModel.fromJson(json['patient']);
    date = DateTime.parse(json['date']);
    time = json['time'];
    type = json['type'];
    status = json['status'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appointmentID'] = appointmentID;
    data['doctor'] = doctor.toJson();
    data['patient'] = patient.toJson();
    data['date'] = date.toIso8601String();
    data['type'] = type;
    data['time'] = time;
    data['status'] = status;
    data['createdAt'] = createdAt.toIso8601String();
    data['updatedAt'] = updatedAt.toIso8601String();
    return data;
  }
}


