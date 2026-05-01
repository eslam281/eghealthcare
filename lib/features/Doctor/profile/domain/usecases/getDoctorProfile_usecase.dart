import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/doctorProfile_repository.dart';

class GetDoctorProfileUseCase extends UseCase<Either, String?>{
  @override
  Future<Either<dynamic, dynamic>> call({String? params}) async{
    return await sl<DoctorProfileRepository>().getDoctorProfile(params!);

  }

}