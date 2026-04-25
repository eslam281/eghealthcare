
import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/findDoctor_repository.dart';

class CreateAppointmentUseCase implements UseCase<Either,Map<String, dynamic>?>{
  @override
  Future<Either<dynamic, dynamic>> call({Map<String, dynamic>? params}) async{
    return await sl<FindDoctorRepository>().createAppointment(params!);
  }

}