import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/dashboard_repository.dart';

class GetAppointmentUseCase extends UseCase<Either, int?>{
  @override
  Future<Either<dynamic, dynamic>> call({int? params}) async{
    return await sl<DocDashboardRepository>().getAppointment();
  
  }
  
} 