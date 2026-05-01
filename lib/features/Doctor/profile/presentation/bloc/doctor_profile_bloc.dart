import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../domain/entities/doctor_entity.dart';

part 'doctor_profile_event.dart';
part 'doctor_profile_state.dart';

class DoctorProfileBloc extends Bloc<DoctorProfileEvent, DoctorProfileState> {
  DoctorProfileBloc() : super(DoctorProfileInitial()) {
    on<LoadedDoctorProfileRequest>(_onLoadedRequest);
  }
  Future<void> _onLoadedRequest(LoadedDoctorProfileRequest event,Emitter<DoctorProfileState> emit)async{

  }
}
