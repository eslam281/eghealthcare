import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
      emit(DashboardLoaded());
    } catch (e) {
      emit(DashboardError("Failed to load dashboard"));
    }
  }
}
