import 'package:dartz/dartz.dart';

abstract class DoctorPatientsRepository {
  Future<Either> getPatients();
}