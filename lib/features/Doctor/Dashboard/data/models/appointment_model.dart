
import 'package:eghealthcare/core/shared/model/appointment_model.dart';

import '../../domain/entities/appointment_entity.dart';


extension AppointmentEntityExtension on AppointmentModel{
  AppointmentEntity toAppointmentEntity() {
    return AppointmentEntity(
      doctorName: doctor.name,
      type: type,
      date: date,
      time: time,
    );
  }
}