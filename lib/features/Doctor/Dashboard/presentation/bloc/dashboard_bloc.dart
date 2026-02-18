import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/domain/entities/user.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/dashboard_summary_entity.dart';
import '../../domain/entities/patient_entity.dart';

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
      final List<PatientEntity> dummyPatients = [
        const PatientEntity(
          id: "1",
          name: "John Anderson",
          age: 45,
          gender: "Male",
          image: "https://i.pravatar.cc/150?img=3",
          medicalSummary:
          "History of hypertension, managed with medication. Regular checkups recommended. No known allergies.",
        ),
        const PatientEntity(
          id: "2",
          name: "Sarah Williams",
          age: 32,
          gender: "Female",
          image: "https://i.pravatar.cc/150?img=5",
          medicalSummary:
          "Diabetic patient. Monitoring blood sugar levels regularly. Mild allergy to penicillin.",
        ),
        const PatientEntity(
          id: "3",
          name: "Michael Brown",
          age: 50,
          gender: "Male",
          image: "https://i.pravatar.cc/150?img=8",
          medicalSummary:
          "High cholesterol levels. On dietary plan and medication.",
        ),
      ];

      emit(DashboardLoaded(
        user: user,
        summary: summary,
        upcomingAppointments: appointments,
        patients: dummyPatients,
      ));
    } catch (e) {
      emit(DashboardError("Failed to load dashboard"));
    }
  }
}
