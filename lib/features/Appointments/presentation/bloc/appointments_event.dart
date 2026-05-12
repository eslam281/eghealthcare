part of 'appointments_bloc.dart';

@immutable
abstract class AppointmentsEvent {}

class LoadAppointments extends AppointmentsEvent {}

class DeleteAppointments extends AppointmentsEvent {
  final int id;

  DeleteAppointments(this.id);
}

class EditAppointments extends AppointmentsEvent {
  final int id;

  final Map<String, dynamic> body;

  EditAppointments({
    required this.id,
    required this.body,
  });
}

class ChoiceFilter extends AppointmentsEvent {
  final AppointmentFilter filter;

  ChoiceFilter(this.filter);
}