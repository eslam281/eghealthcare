import 'package:dartz/dartz.dart';

import '../../../../../injection_container.dart';
import '../../domain/repository/doctorPatients_repository.dart';
import '../source/doctorPatientsApi.dart';

class DoctorPatientsRepositoryImpl implements DoctorPatientsRepository{
  @override
  Future<Either<dynamic, dynamic>> getPatients() async{
   return await sl<DoctorPatientsApi>().getPatients();
  }

}