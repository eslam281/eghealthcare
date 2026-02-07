
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routes/app_initial_route.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AppStartDecider appStartDecider;

SplashCubit(this.appStartDecider) : super(SplashInitial());

  Future<void> checkAppStart() async {
    emit(SplashLoading());
    final route = await appStartDecider.decideRoute();
    emit(route);
  }
}

