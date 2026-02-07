import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    // final route = await appStartDecider.decideRoute();
    // Navigator.pushReplacementNamed(context, route);

// final role = await roleService.getCurrentRole();
//
// if (role == UserRole.doctor) {
// Navigator.pushReplacementNamed(context, Routes.doctorHome);
// } else {
// Navigator.pushReplacementNamed(context, Routes.patientHome);
// }
  }
}
