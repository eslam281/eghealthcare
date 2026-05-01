
import 'package:eghealthcare/core/shared/model/appointment_model.dart';

import '../../../../core/services/role_service.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/appointment_entity.dart';


extension AppointmentEntityExtension on AppointmentModel{
  AppointmentEntity toAppointmentEntity(UserRole role) {
    return AppointmentEntity(
      id: appointmentID,
      name:role == UserRole.patient?doctor.name: patient.name,
      type: type,
      date: date,
      time: time,
      status: status,
      avtar: role == UserRole.patient?doctor.avatar:patient.avatar ,
      patientID: patient.patientID ,
      doctorID: doctor.doctorID ,
    );
  }
}