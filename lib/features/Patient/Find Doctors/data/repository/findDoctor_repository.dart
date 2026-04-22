
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/findDoctor_repository.dart';
import '../source/findDoctor_api.dart';

class FindDoctorRepositoryImpl implements FindDoctorRepository {
  @override
  Future<Either> getDoctors() async{
    return await sl<FindDoctorApi>().getDoctors();
  }

}