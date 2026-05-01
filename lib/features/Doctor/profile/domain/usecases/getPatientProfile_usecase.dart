
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/usecase/usecase.dart';

import '../../../../../injection_container.dart';
import '../../../../Patient/profile/domain/repository/patientProfile_repository.dart';

class GetPatientProfileUserUseCase extends UseCase<Either, String?>{
  @override
  Future<Either> call({params}) async{
    return await sl<PatientProfileRepository>().getPatientProfile(params!);
  }

}