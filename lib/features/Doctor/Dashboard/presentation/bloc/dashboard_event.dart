part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}
final class LoadDashboardRequested extends DashboardEvent {}
final class RefreshDashboardRequested extends DashboardEvent {}

final class DeleteAppointments extends DashboardEvent {
  final int id;
  DeleteAppointments(this.id);
}

