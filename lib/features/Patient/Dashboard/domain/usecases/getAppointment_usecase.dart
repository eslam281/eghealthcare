import 'package:dartz/dartz.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../injection_container.dart';
import '../repository/dashboard_repository.dart';



class GetPatientAppointmentUseCase extends UseCase<Either, int?>{
  @override
  Future<Either> call({int? params}) async{
    final response =  await sl<PDashboardRepository>().getAppointment();
    return response.fold(
          (l) => Left(l),
          (appointments) {
        final today = DateTime.now().toLocal();

        final filtered = appointments.where((a) {
          final d = a.date.toLocal();
          return d.year == today.year &&
              d.month == today.month &&
              d.day == today.day;
        }).toList();

        return Right(filtered);
      },
    );
  }
  
} 