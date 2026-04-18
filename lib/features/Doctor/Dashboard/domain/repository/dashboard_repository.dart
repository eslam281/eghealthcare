import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either> getPatients();
  Future<Either> getUser();
  Future<Either> getPatient(String id);

}