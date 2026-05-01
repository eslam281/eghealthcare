
import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/patientProfile_repository.dart';
import '../source/patientProfile_Api.dart';

class PatientProfileRepositoryImpl implements PatientProfileRepository{
  @override
  Future<Either<dynamic, dynamic>> getPatientProfile(String id) async{
    return await sl<PatientProfileApi>().getPatientProfile(id);
  }

}