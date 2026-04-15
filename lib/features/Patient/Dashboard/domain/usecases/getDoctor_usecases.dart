
import 'package:dartz/dartz.dart';
import 'package:eghealthcare/core/usecase/usecase.dart';

import '../../../../../injection_container.dart';
import '../repository/doctor_repository.dart';

class GetDoctorUseCases extends UseCase<Either, int?>{
  @override
  Future<Either> call({params}) async{
    return await sl<DoctorRepository>().getDoctors();

  }

}