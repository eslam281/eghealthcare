
import 'package:dartz/dartz.dart';

abstract class FindDoctorRepository {
  Future <Either> getDoctors();
  Future <Either> search(String query);
  Future <Either> createAppointment(Map<String,dynamic> appointmentCreate);
}
