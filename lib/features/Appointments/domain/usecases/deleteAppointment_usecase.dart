
import 'package:dartz/dartz.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../injection_container.dart';
import '../repository/appointment_repository.dart';

class DeleteAppointmentUseCase extends UseCase<Either, int?>{
  @override
  Future<Either<dynamic, dynamic>> call({int? params}) async{
    return await sl<AppointmentRepository>().deleteAppointment(params!);
  }

}