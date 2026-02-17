import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/domain/entities/user.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/dashboard_summary_entity.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardEvent>(_onLoadDashboard);
  }
  Future<void> _onLoadDashboard(DashboardEvent event, Emitter<DashboardState> emit,)async {
    emit(DashboardLoading());
    try {
      await Future.delayed(const Duration(seconds: 1)); // mock API
      final user = UserEntity(fullName: "John",imageURL:"https://randomuser.me/api/portraits/men/76.jpg");
      final summary = DashboardSummary(upcoming: 3, visits: 1, doctors: 6);
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

      emit(DashboardLoaded(
        user: user,
        summary: summary,
        upcomingAppointments: appointments,
      ));
    } catch (e) {
      emit(DashboardError("Failed to load dashboard"));
    }
  }
}
