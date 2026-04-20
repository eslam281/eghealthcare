import 'package:dartz/dartz.dart';

abstract class AppointmentRepository {
  Future <Either> getAppointment();
  Future <Either> deleteAppointment(int id);
}