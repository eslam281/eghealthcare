
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/doctor_repository.dart';
import '../source/doctor.dart';

class DoctorRepositoryImpl extends DoctorRepository {
  @override
  Future<Either<dynamic, dynamic>> getDoctors() async{
    return await sl<DoctorApiImpl>().getDoctors();
  }

  @override
  Future<Either<dynamic, dynamic>> getDoctor(String id) async{
    return await sl<DoctorApiImpl>().getDoctor(id);
  }

}