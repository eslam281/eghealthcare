
import 'package:dartz/dartz.dart';

abstract class DoctorProfileRepository {
  Future<Either> getDoctorProfile(String id);
}