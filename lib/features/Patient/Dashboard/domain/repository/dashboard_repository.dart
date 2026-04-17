import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either> getDoctors();
  Future<Either> getUser();
  Future<Either> getDoctor(String id);

}