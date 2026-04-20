part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class LoadDashboardRequested extends DashboardEvent {}

class RefreshDashboardRequested extends DashboardEvent {}

final class DeleteAppointments extends DashboardEvent {
  final int id;
  DeleteAppointments(this.id);
}
