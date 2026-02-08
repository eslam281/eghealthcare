import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../injection_container.dart';
import '../../data/models/create_user_req.dart';
import '../../data/models/signin_user_req.dart';
import '../../domain/usecases/signin.dart';
import '../../domain/usecases/signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(AuthInitial()) {

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await sl<SignInUseCase>().call(
        params: SignInUserReq(
          email: event.email,
          password: event.password,
        ),
      );

      result.fold(
            (message) => emit(AuthFailure(message)),
            (_) => emit(AuthSuccess()),
      );
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await sl<SingUpUseCase>().call(
        params: CreateUserReq(
          fullName:event.name,
          email:event.email,
          password:event.password,
        ),
      );

      result.fold(
            (message) => emit(AuthFailure(message)),
            (_) => emit(AuthSuccess()),
      );
    });

    // on<LogoutRequested>((event, emit) async {
    //   await repo.logout();
    //   emit(AuthInitial());
    // });
  }
}