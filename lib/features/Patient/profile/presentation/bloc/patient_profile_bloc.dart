import 'package:bloc/bloc.dart';
import 'package:eghealthcare/features/Patient/profile/domain/entities/patientProfile_entities.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../../../Doctor/profile/domain/usecases/getPatientProfile_usecase.dart';

part 'patient_profile_event.dart';
part 'patient_profile_state.dart';

class PatientProfileBloc extends Bloc<PatientProfileEvent, PatientProfileState> {
  PatientProfileBloc() : super(PatientProfileInitial()) {
    on<LoadedPatientProfileRequest>(_onLoadedRequest);
  }
  Future<void> _onLoadedRequest (LoadedPatientProfileRequest event ,Emitter<PatientProfileState> emit)async{
    emit(PatientProfileLoading());
    late final PatientProfileEntities patientProfileEntities;
    try{
      final response=await sl<GetPatientProfileUserUseCase>().call(params:event.id);
      response.fold((l) => l, (r) {
        patientProfileEntities =r;
      },);
    }catch(e){
      emit(PatientProfileError(e.toString()));
    }
    emit(PatientProfileLoaded(patientProfileEntities));

  }
}
