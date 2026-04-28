import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../domain/entities/patient_entity.dart' show PatientEntity;
import '../../domain/usecases/getPatientDoctor_usecase.dart';

part 'my_patients_event.dart';
part 'my_patients_state.dart';

class MyPatientsBloc extends Bloc<MyPatientsEvent, MyPatientsState> {
  MyPatientsBloc() : super(MyPatientsInitial()) {
    on<MyPatientsRequested>(_onMyPatientsRequested);
  }
  Future<void> _onMyPatientsRequested(MyPatientsRequested event, Emitter<MyPatientsState> emit) async {
    emit(MyPatientsLoading());
    try {
      late final List<PatientEntity> dummyPatients ;
      final response =await sl<GetPatientDoctorUseCase>().call();
      response.fold((l) => l, (r) {
        dummyPatients =r;
      },);
      emit(MyPatientsLoaded(dummyPatients));
    } catch (e) {
      emit(MyPatientsError(e.toString()));
    }
  }

}
