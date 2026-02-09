import 'package:bloc/bloc.dart';
import 'package:eghealthcare/features/auth/domain/usecases/signout.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../core/services/role_service.dart';
import '../../../../injection_container.dart';
import '../../data/models/create_user_req.dart';
import '../../data/models/signin_user_req.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/signin.dart';
import '../../domain/usecases/signin_Google.dart';
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
            (_) async{
              // await sl<RoleService>().saveRole(event.userRole);
              emit(AuthSuccess());
            }
      );
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await sl<SignInGoogleUseCase>().call();

     if (result.isLeft()) {
        final message = result.fold((l) => l, (r) => null);
        if (!emit.isDone) emit(AuthFailure(message!));
        return;
      }
      if (!emit.isDone) emit(AuthSuccess());
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await sl<SingUpUseCase>().call(
        params: CreateUserReq(
          fullName:event.name,
          email:event.email,
          password:event.password,
          userRole:event.userRole==UserRole.patient?"patient":"doctor",
        ),
      );

      if (result.isLeft()) {
        final message = result.fold((l) => l, (r) => null);
        if (!emit.isDone) emit(AuthFailure(message!));
        return;
      }
      await sl<RoleService>().saveRole(event.userRole);
      if (!emit.isDone)emit(AuthSuccess());

    });

    on<LogoutRequested>((event, emit) async {
      final result = await sl<SignOutUseCase>().call();
      if (result.isLeft()) {
        final message = result.fold((l) => l, (r) => null);
        if (!emit.isDone) emit(AuthFailure(message!));
        return;
      }
      await sl<RoleService>().clearRole();
      if (!emit.isDone)emit(AuthInitial());
    });

    on<GetUserRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await sl<GetUserUseCase>().call();

      result.fold(
            (message) => emit(AuthFailure(message)),
            (re) {
              print(re);
              emit(AuthSuccess());
        } ,
      );
    });
  }
}
