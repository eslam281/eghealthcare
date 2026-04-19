import 'package:dartz/dartz.dart';

abstract class DocDashboardRepository {
  Future<Either> getPatients();
  Future<Either> getUser();
  Future<Either> getPatient(String id);
  Future<Either> getAppointment();

}