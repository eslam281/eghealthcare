import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/usecases/getAppointment_usecase.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(AppointmentsInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
  }

  Future<void> _onLoadAppointments(LoadAppointments event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoading());

    try {
      late final List<AppointmentEntity> appointments ;
      try{
        final response = await sl<GetAppointmentUseCase>().call();
        appointments = response.fold((l) => [], (r) => r);
      }catch(e){
        print(e);
        emit(AppointmentsError("$e"));
      }
      emit(AppointmentsLoaded(
        upcomingAppointments: appointments,
      ));
    } catch (e) {
      emit(AppointmentsError("Failed to load dashboard"));
    }
  }

}
