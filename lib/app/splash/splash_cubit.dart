import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

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

