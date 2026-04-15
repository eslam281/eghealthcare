import 'package:dartz/dartz.dart';

abstract class GetDoctorRepository {
  Future<Either> getDoctors();
}