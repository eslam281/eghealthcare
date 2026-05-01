import 'package:bloc/bloc.dart';
import 'package:eghealthcare/features/Patient/profile/domain/entities/patientProfile_entities.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../domain/usecases/getPatientProfile_usecase.dart';

part 'patient_profile_event.dart';
part 'patient_profile_state.dart';

class PatientProfileBloc extends Bloc<PatientProfileEvent, PatientProfileState> {
  PatientProfileBloc() : super(PatientProfileInitial()) {
    on<LoadedPatientProfileRequest>(_onLoadedRequest);
  }
  late final String userID;
  Future<void> _onLoadedRequest (LoadedPatientProfileRequest event ,Emitter<PatientProfileState> emit)async{
    emit(PatientProfileLoading());
    try{
      final response=await sl<GetPatientProfileUserUseCase>().call(params:event.id);
      userID= (await sl<FlutterSecureStorage>().read(key: 'uid'))!;
      response.fold((l) => emit(PatientProfileError(l.toString())),
              (r) => emit(PatientProfileLoaded(r,userID: userID))
      );
    }catch(e){
      emit(PatientProfileError(e.toString()));
    }

  }
}
