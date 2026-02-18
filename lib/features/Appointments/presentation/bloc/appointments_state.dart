part of 'appointments_bloc.dart';

@immutable
sealed class AppointmentsState {}

final class AppointmentsInitial extends AppointmentsState {}
final class AppointmentsLoading extends AppointmentsState {}

final class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentEntity> upcomingAppointments;

  AppointmentsLoaded({
    required this.upcomingAppointments,
  });
}

final class AppointmentsError extends AppointmentsState {
  final String message;
  AppointmentsError(this.message);
}
