import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/domain/entities/user.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/dashboard_summary_entity.dart';
import '../../domain/entities/doctor_entity.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardRequested>(_onLoadDashboard);
    on<RefreshDashboardRequested>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
      LoadDashboardRequested event,
      Emitter<DashboardState> emit,
      ) async {
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
      final doctors = [
        DoctorEntity(name: "Dr. Sarah Mitchell", specialty: "Cardiologist", imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg'),
        DoctorEntity(name: "Dr. Sarah Mitchell", specialty: "Cardiologist", imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg'),
        DoctorEntity(name: "Dr. Sarah Mitchell", specialty: "Cardiologist", imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg'),
        ];

      emit(DashboardLoaded(
        user: user,
        summary: summary,
        upcomingAppointments: appointments,
        featuredDoctors: doctors,
      ));
    } catch (e) {
      emit(DashboardError("Failed to load dashboard"));
    }
  }

  Future<void> _onRefreshDashboard(
      RefreshDashboardRequested event,
      Emitter<DashboardState> emit,
      ) async {
    add(LoadDashboardRequested());
  }
}
