import 'package:dartz/dartz.dart';

abstract class PatientProfileRepository {
  Future<Either> getPatientProfile(String id);
}