
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repository/appointment_repository.dart';

class EditAppointmentUseCase extends UseCase<Either, (int,Map<String,dynamic>)>{
  @override
  Future<Either<dynamic, dynamic>> call({(int,Map<String,dynamic>)? params}) async{
    return await sl<AppointmentRepository>().editAppointment(params!.$1,params.$2);
  }

}