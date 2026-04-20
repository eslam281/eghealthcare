part of 'appointments_bloc.dart';

@immutable
sealed class AppointmentsEvent {}

final class AppointmentCreated extends AppointmentsEvent {}
final class LoadAppointments extends AppointmentsEvent {}
final class DeleteAppointments extends AppointmentsEvent {
  final int id;
  DeleteAppointments(this.id);
}
