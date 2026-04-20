import 'package:dartz/dartz.dart';

abstract class PDashboardRepository {
  Future<Either> getDoctors();
  Future<Either> getUser();
  Future<Either> getDoctor(String id);
  Future<Either> getAppointment();

}