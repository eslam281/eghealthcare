import 'dart:async'; // 1. ضفنا الـ import ده عشان الـ StreamSubscription
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/role_service.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/appointment_entity.dart';
import '../../domain/usecases/deleteAppointment_usecase.dart';
import '../../domain/usecases/editAppointment_usecase.dart';
import '../../domain/usecases/getAppointment_usecase.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

enum AppointmentFilter {
  pending,
  scheduled,
  completed,
  cancelled,
}

extension AppointmentFilterX on AppointmentFilter {
  String get title {
    switch (this) {
      case AppointmentFilter.pending:
        return "Pending";

      case AppointmentFilter.scheduled:
        return "Scheduled";

      case AppointmentFilter.completed:
        return "Completed";

      case AppointmentFilter.cancelled:
        return "Cancelled";
    }
  }
}

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {

  StreamSubscription<RemoteMessage>? _messagingSubscription;

  AppointmentsBloc() : super(AppointmentsInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<DeleteAppointments>(_onDeletedAppointments);
    on<EditAppointments>(_onEditAppointments);
    on<ChoiceFilter>(_onChoiceFilter);
    on<RefreshAppointments>((event, emit) async { add(LoadAppointments()); });
    _listenToNotifications();
  }

  // Source Of Truth
  List<AppointmentEntity> _appointments = [];

  AppointmentFilter _selectedFilter = AppointmentFilter.pending;

  UserRole? role;

  // ========================= NOTIFICATIONS =========================

  void _listenToNotifications() {
    _messagingSubscription = FirebaseMessaging.onMessage.listen((message) {
      if (!isClosed) {
        add(RefreshAppointments());
      }
    });
  }

  // ========================= CLOSE (CLEAN UP) =========================
  @override
  Future<void> close() {
    _messagingSubscription?.cancel();
    return super.close();
  }

  // ========================= LOAD =========================

  Future<void> _onLoadAppointments(LoadAppointments event, Emitter<AppointmentsState> emit,) async {
    emit(AppointmentsLoading());
    try {
      role = await sl<RoleService>().getCurrentRole();
      final response = await sl<GetAppointmentUseCase>().call();
      _appointments = response.fold(
            (l) => [],
            (r) => r,
      );

      _emitLoaded(emit);
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  // ========================= DELETE =========================

  Future<void> _onDeletedAppointments(
      DeleteAppointments event,
      Emitter<AppointmentsState> emit,
      ) async {
    try {
      await sl<DeleteAppointmentUseCase>()
          .call(params: event.id);

      _appointments.removeWhere(
            (e) => e.id == event.id,
      );

      _emitLoaded(emit);
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  // ========================= EDIT =========================

  Future<void> _onEditAppointments(EditAppointments event, Emitter<AppointmentsState> emit,) async {
    try {
      await sl<EditAppointmentUseCase>().call(
        params: (event.id, event.body) as (int, Map<String, dynamic>)?,);

      final index = _appointments.indexWhere(
            (e) => e.id == event.id,
      );

      if (index != -1) {
        final old = _appointments[index];

        _appointments[index] = old.copyWith(
          status: event.body["status"],
        );
      }

      _emitLoaded(emit);
    } catch (e) {
      emit(AppointmentsError(e.toString()));
    }
  }

  // ========================= FILTER =========================

  Future<void> _onChoiceFilter(ChoiceFilter event, Emitter<AppointmentsState> emit,) async {
    _selectedFilter = event.filter;
    _emitLoaded(emit);
  }

  // ========================= HELPER =========================

  void _emitLoaded(Emitter<AppointmentsState> emit,) {
    emit(
      AppointmentsLoaded(
        appointments: _appointments,
        selectedFilter: _selectedFilter,
      ),
    );
  }
}