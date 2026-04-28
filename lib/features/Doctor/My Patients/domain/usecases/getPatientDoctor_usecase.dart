import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/doctorPatients_repository.dart';

class GetPatientDoctorUseCase extends UseCase<Either, int?>{
  @override
  Future<Either<dynamic, dynamic>> call({int? params}) async{
    return await sl<DoctorPatientsRepository>().getPatients();

  }

}