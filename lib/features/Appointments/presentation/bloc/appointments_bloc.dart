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
    on<ChoiceFilter>(_onChoiceFilter);
  }
  List<(String, int)> tabs = [
    ("Pending", 0),
    ("Scheduled", 0),
    ("Completed", 0),
    ("Cancelled", 0),
  ];
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
      for (int index=0 ;index<tabs.length;index++) {
          final pending=appointments.where((element) {
            return element.status == tabs[index].$1;
          },).toList();
          tabs[index]=(tabs[index].$1,pending.length);
        }
        final filteredAppointments=appointments.where((element) {
          return element.status == "Pending";
        },).toList();


      emit(AppointmentsLoaded(upcomingAppointments: filteredAppointments,));
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

  Future<void> _onChoiceFilter(ChoiceFilter event, Emitter<AppointmentsState> emit) async {
    emit(AppointmentsLoading());
    final filteredAppointments=appointments.where((element) {
      return element.status == tabs[event.index].$1;
    },).toList();
    tabs[event.index]=(tabs[event.index].$1,filteredAppointments.length);
    emit(AppointmentsLoaded(upcomingAppointments: filteredAppointments,));
  }

}
