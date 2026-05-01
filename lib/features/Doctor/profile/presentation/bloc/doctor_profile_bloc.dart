import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../domain/entities/doctor_entity.dart';
import '../../domain/usecases/getDoctorProfile_usecase.dart';

part 'doctor_profile_event.dart';
part 'doctor_profile_state.dart';

class DoctorProfileBloc extends Bloc<DoctorProfileEvent, DoctorProfileState> {
  DoctorProfileBloc() : super(DoctorProfileInitial()) {
    on<LoadedDoctorProfileRequest>(_onLoadedRequest);
  }
  late final String userID;
  Future<void> _onLoadedRequest(LoadedDoctorProfileRequest event,Emitter<DoctorProfileState> emit)async{
    emit(DoctorProfileLoading());
    try{
      final response=await sl<GetDoctorProfileUseCase>().call(params:event.id);
      userID= (await sl<FlutterSecureStorage>().read(key: 'uid'))!;
      response.fold((l) => emit(DoctorProfileError(l.toString())),
              (r) => emit(DoctorProfileLoaded(r,userID: userID))
      );
    }catch(e){
      emit(DoctorProfileError(e.toString()));
    }
  }
}
