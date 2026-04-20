import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../../../Appointments/domain/usecases/deleteAppointment_usecase.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/dashboard_summary_entity.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/getAppointment_usecase.dart';
import '../../domain/usecases/getDoctor_usecases.dart';
import '../../domain/usecases/getUser_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardRequested>(_onLoadDashboard);
    on<RefreshDashboardRequested>(_onRefreshDashboard);
    on<DeleteAppointments>(_onDeletedAppointments);
  }
  late final UserEntity user;
  late final List<DoctorEntity> doctors;
  late  List<AppointmentEntity> appointments;
  final summary = DashboardSummary(upcoming: 3, visits: 1, doctors: 6);

  Future<void> _onLoadDashboard(LoadDashboardRequested event, Emitter<DashboardState> emit,) async {
    emit(DashboardLoading());
      try{
        final response = await sl<PGetUserUseCase>().call();
        user = response.fold((l) => l, (r) => r);
      }catch(e){
      print(e);
      emit(DashboardError("$e"));
       }

      try{
       final response = await sl<GetDoctorsUseCases>().call();
       doctors = response.fold((l) => [], (r) => r);
      }catch(e){
        print(e);
        emit(DashboardError("$e"));
      }
      try{
        final response = await sl<GetPatientAppointmentUseCase>().call();
        appointments = response.fold((l) => [], (r) => r);
      }catch(e){
        print(e);
        emit(DashboardError("$e"));
      }
      emit(DashboardLoaded(
        user: user,
        summary: summary,
        upcomingAppointments: appointments,
        featuredDoctors: doctors,
      ));

  }

  Future<void> _onRefreshDashboard(RefreshDashboardRequested event, Emitter<DashboardState> emit,) async {
    add(LoadDashboardRequested());
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
      upcomingAppointments: appointments,
      user: user,
      summary: summary,
      featuredDoctors: doctors,
    ));
  }

}
