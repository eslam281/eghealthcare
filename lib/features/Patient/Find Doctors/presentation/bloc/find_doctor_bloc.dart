import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/usecases/findDoctor_usecase.dart';

part 'find_doctor_event.dart';
part 'find_doctor_state.dart';

class FindDoctorBloc extends Bloc<FindDoctorEvent, FindDoctorState> {
  FindDoctorBloc() : super(FindDoctorInitial()) {
    on<LoadDoctorRequested>(_onLoadDoctor);
    on<RefreshDoctorRequested>(_onRefreshDoctor);
  }
  late final List<DoctorEntity> doctors ;
  Future<void> _onLoadDoctor(LoadDoctorRequested event, Emitter<FindDoctorState> emit,) async {
    emit(FindDoctorLoading());
    try{
      final response = await sl<FindDoctorUseCase>().call();
      doctors = response.fold((l) => [], (r) => r);
      emit(FindDoctorLoaded(doctors));
    }catch(e){
      print(e);
      emit(FindDoctorError("$e"));
    }
    emit(FindDoctorLoaded(doctors));
  }

  Future<void> _onRefreshDoctor(RefreshDoctorRequested event, Emitter<FindDoctorState> emit,) async {
    add(LoadDoctorRequested());
  }
}
