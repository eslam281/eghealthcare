import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'patient_profile_event.dart';
part 'patient_profile_state.dart';

class PatientProfileBloc extends Bloc<PatientProfileEvent, PatientProfileState> {
  PatientProfileBloc() : super(PatientProfileInitial()) {
    on<LoadedPatientProfileRequest>(_onLoadedRequest);
  }
  Future<void> _onLoadedRequest (LoadedPatientProfileRequest event ,Emitter<PatientProfileState> emit){

  }
}
