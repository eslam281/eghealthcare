import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../../../Appointments/domain/usecases/deleteAppointment_usecase.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/dashboard_summary_entity.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/user_entity.dart' show UserEntity;
import '../../domain/usecases/getAppointment_usecase.dart';
import '../../domain/usecases/getUser_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardRequested>(_onLoadDashboard);
    on<DeleteAppointments>(_onDeletedAppointments);
  }
  late final UserEntity user;
  late final List<AppointmentEntity> appointments;
  late final DashboardSummary summary;
  late final List<PatientEntity> dummyPatients;

  Future<void> _onLoadDashboard(DashboardEvent event, Emitter<DashboardState> emit,)async {
    emit(DashboardLoading());
    try {

      summary = DashboardSummary(upcoming: 3, visits: 1, doctors: 6);
      dummyPatients = [
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
      try{
        final response = await sl<DocGetUserUseCase>().call();
       response.fold((l)=>l, (r) => user=r);
      }catch(e){
        print(e);
        emit(DashboardError("$e"));
      }
      try{
        final response = await sl<GetDocAppointmentUseCase>().call();
        appointments = response.fold((l) => [], (r) => r);
      }catch(e){
        print(e);
        emit(DashboardError("$e"));
      }

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
  Future<void> _onDeletedAppointments(DeleteAppointments event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      await sl<DeleteAppointmentUseCase>().call(params: event.id);
      appointments.removeWhere((element) => element.id == event.id);

    }catch(e){
      emit(DashboardError("Failed to delete dashboard"));
    }
    emit(DashboardLoaded(
      user: user,
      summary: summary,
      upcomingAppointments: appointments,
      patients: dummyPatients,
    ));
  }

}
