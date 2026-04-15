
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/doctor_repository.dart';
import '../source/doctor.dart';

class DoctorRepositoryImpl extends DoctorRepository {
  @override
  Future<Either> getDoctors() async{
    return await sl<DoctorApi>().getDoctors();
  }

  @override
  Future<Either> getDoctor(String id) async{
    return await sl<DoctorApi>().getDoctor(id);
  }

}