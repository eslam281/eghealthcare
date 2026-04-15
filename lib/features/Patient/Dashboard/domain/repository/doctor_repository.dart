import 'package:dartz/dartz.dart';

abstract class DoctorRepository {
  Future<Either> getDoctors();
  Future<Either> getDoctor(String id);

}