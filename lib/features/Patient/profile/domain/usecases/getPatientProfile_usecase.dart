
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/usecase/usecase.dart';

import '../../../../../injection_container.dart';
import '../repository/patientProfile_repository.dart';

class GetPatientProfileUserUseCase extends UseCase<Either, String?>{
  @override
  Future<Either> call({params}) async{
    return await sl<PatientProfileRepository>().getPatientProfile(params!);
  }

}