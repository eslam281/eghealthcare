
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/doctorProfile_repository.dart';
import '../source/doctorProfile_api.dart';

class DoctorProfileRepositoryImpl implements DoctorProfileRepository{
  @override
  Future<Either<dynamic, dynamic>> getDoctorProfile(String id) async{
    return await sl<DoctorProfileApi>().getDoctorProfile(id);
  }

}