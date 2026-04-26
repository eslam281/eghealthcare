
import 'package:eghealthcare/core/shared/model/appointment_model.dart';

import '../../domain/entities/appointment_entity.dart';


extension AppointmentEntityExtension on AppointmentModel{
  AppointmentEntity toAppointmentEntity() {
    return AppointmentEntity(
      id: appointmentID,
      doctorName: doctor.name,
      type: type,
      date: date,
      time: time,
      avatar:patient.avatar
    );
  }
}