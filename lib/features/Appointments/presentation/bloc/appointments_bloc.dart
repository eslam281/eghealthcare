import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/appointment_entity.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
  }

  Future<void> _onLoadAppointments(LoadAppointments event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoading());

    try {
      await Future.delayed(const Duration(seconds: 1)); // mock API

      final appointments = [
        AppointmentEntity(
          doctorName: "Dr. Sarah Mitchell",
          type: "Follow-up Consultation",
          date: "Jan 27, 2025",
          time: "09:00 AM",
        ),
        AppointmentEntity(
          doctorName: "Dr. Sarah Mitchell",
          type: "Annual Checkup",
          date: "Jan 27, 2025",
          time: "10:30 AM",
        ),
      ];


      emit(AppointmentsLoaded(
        upcomingAppointments: appointments,
      ));
    } catch (e) {
      emit(AppointmentsError("Failed to load dashboard"));
    }
  }

}
