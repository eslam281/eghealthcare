
import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/findDoctor_repository.dart';

class FindDoctorUseCase implements UseCase<Either,int?>{
  @override
  Future<Either<dynamic, dynamic>> call({int? params}) async{
    return await sl<FindDoctorRepository>().getDoctors();
  }

}