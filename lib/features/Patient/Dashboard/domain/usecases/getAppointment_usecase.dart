import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/dashboard_repository.dart';



class GetPatientAppointmentUseCase extends UseCase<Either, int?>{
  @override
  Future<Either> call({int? params}) async{
    return await sl<PDashboardRepository>().getAppointment();
  
  }
  
} 