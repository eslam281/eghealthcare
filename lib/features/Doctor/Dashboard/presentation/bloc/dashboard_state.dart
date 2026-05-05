part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}
final class DashboardLoading extends DashboardState {}
final class DashboardLoaded extends DashboardState {
  final UserEntity user;
  final DashboardSummary summary;
  final List<AppointmentEntity> upcomingAppointments;
  final List<PatientEntity> patients;

  DashboardLoaded({
    required this.user,
    required this.summary,
    required this.upcomingAppointments,
    required this.patients,
  });
}
final class DashboardError extends DashboardState{
  final String message;
  DashboardError(this.message);
}
