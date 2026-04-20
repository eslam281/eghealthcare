import 'package:dartz/dartz.dart';

import 'package:eghealthcare/features/Appointments/domain/repository/appointment_repository.dart';

import '../../../../injection_container.dart';
import '../source/appointmentApi.dart';

class AppointmentRepositoryImp extends AppointmentRepository {
  @override
  Future<Either<dynamic, dynamic>> getAppointment() async{
    return await sl<AppointmentApi>().getAppointment();
  }

}