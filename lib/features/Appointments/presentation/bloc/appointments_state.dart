part of 'appointments_bloc.dart';

@immutable
abstract class AppointmentsState {}

class AppointmentsInitial extends AppointmentsState {}

class AppointmentsLoading extends AppointmentsState {}

class AppointmentsError extends AppointmentsState {
  final String message;

  AppointmentsError(this.message);
}

class AppointmentsLoaded extends AppointmentsState {
  final List<AppointmentEntity> appointments;

  final AppointmentFilter selectedFilter;

  AppointmentsLoaded({
    required this.appointments,
    required this.selectedFilter,
  });

  // Filtered List
  List<AppointmentEntity> get filteredAppointments {
    return appointments.where((e) {
      return e.status == selectedFilter.title;}).toList();
  }

  // Tabs Counts
  Map<AppointmentFilter, int> get counts {
    return {
      for (final filter in AppointmentFilter.values)
        filter: appointments.where((e) {return e.status == filter.title;}).length,
    };
  }
}