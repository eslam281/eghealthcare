import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../../../Appointments/domain/usecases/deleteAppointment_usecase.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/entities/dashboard_summary_entity.dart';
import '../../domain/entities/patient_entity.dart';
import '../../domain/entities/user_entity.dart' show UserEntity;
import '../../domain/usecases/chatbot_usecase.dart';
import '../../domain/usecases/getAppointment_usecase.dart';
import '../../domain/usecases/getPatientDoctor_usecase.dart';
import '../../domain/usecases/getUser_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardRequested>(_onLoadDashboard);
    on<DeleteAppointments>(_onDeletedAppointments);
    on<Chatbot>(_onChatbot);
  }
  late final UserEntity user;
  late final List<PatientEntity> patients;
  late final List<AppointmentEntity> appointments;
  late final DashboardSummary summary;
  late List<Map<String, dynamic>> messages=[
    {"text": "Hello, how can I help you today?", "isMe": false,}
  ];

  Future<void> _onLoadDashboard(DashboardEvent event, Emitter<DashboardState> emit,)async {
    emit(DashboardLoading());
    try {

      try{
        final response = await sl<DocGetUserUseCase>().call();
       response.fold((l)=>l, (r) => user=r);
      }catch(e){
        emit(DashboardError("$e"));
      }
      try{
        final response =await sl<GetPatientDoctorDashboardUseCase>().call();
         response.fold((l) => l, (r) {
          patients =r;
        },);
      }catch(e){
        emit(DashboardError("$e"));
      }
      try{
        final response = await sl<GetDocAppointmentUseCase>().call();
        appointments = response.fold((l) => [], (r) => r);
      }catch(e){
        emit(DashboardError("$e"));
      }
      final completed=appointments.where((element) {
        return element.status == "Completed";
      },);
      summary = DashboardSummary(appointments: appointments.length, patients: patients.length, completed: completed.length);
      emit(DashboardLoaded(
        user: user,
        summary: summary,
        upcomingAppointments: appointments,
        patients: patients,
      ));
    } catch (e) {
      emit(DashboardError("Failed to load dashboard $e"));
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
      patients: patients,
    ));
  }
  Future<void> _onChatbot(Chatbot event, Emitter<DashboardState> emit,)async {
      messages.add( {"text": "waht is reques in fron end", "isMe": true});
    emit(ChatbotLoading());
      messages.add( {"text": "Thinking...", "isMe": false, "isThinking": true},);
    try {
      final response = await sl<ChatbotUseCase>().call(params: event.message);
      response.fold((l)=>emit(ChatbotError("Failed to load chatbot $l")),
              (r) {
        messages.removeLast();
        messages.add( {"text": r, "isMe": false});
            emit(ChatbotSuccess(r));
          });

    } catch (e) {
      emit(ChatbotError("Failed to load chatbot $e"));
    }
  }
}
