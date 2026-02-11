part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final UserEntity user;
  final DashboardSummary summary;
  final List<AppointmentEntity> upcomingAppointments;
  final List<DoctorEntity> featuredDoctors;

  DashboardLoaded({
    required this.user,
    required this.summary,
    required this.upcomingAppointments, required this.featuredDoctors,
  });
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}
