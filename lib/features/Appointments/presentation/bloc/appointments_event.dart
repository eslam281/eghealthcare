part of 'appointments_bloc.dart';

@immutable
sealed class AppointmentsEvent {}

final class AppointmentCreated extends AppointmentsEvent {}
final class LoadAppointments extends AppointmentsEvent {}
