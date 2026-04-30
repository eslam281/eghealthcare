import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/usecases/deleteAppointment_usecase.dart';
import '../../domain/usecases/getAppointment_usecase.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<DeleteAppointments>(_onDeletedAppointments);
  }
  late List<AppointmentEntity> appointments ;
  Future<void> _onLoadAppointments(LoadAppointments event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoading());
      try{
        final response = await sl<GetAppointmentUseCase>().call();
        appointments = response.fold((l) => [], (r) => r);
      }catch(e){
        print(e);
        emit(AppointmentsError("$e"));
      }
        final pending=appointments.where((element) {
          return element.status == "Pending";
        },).toList();
      emit(AppointmentsLoaded(upcomingAppointments: pending,));
  }
  Future<void> _onDeletedAppointments(DeleteAppointments event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoading());

    try {
      await sl<DeleteAppointmentUseCase>().call(params: event.id);
      appointments.removeWhere((element) => element.id == event.id);

    }catch(e){
      emit(AppointmentsError("Failed to delete dashboard"));
    }
    emit(AppointmentsLoaded(upcomingAppointments: appointments,));
  }

}
