import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository repo;
//
//   AuthBloc(this.repo) : super(AuthInitial()) {
//
//     on<LoginRequested>((event, emit) async {
//       emit(AuthLoading());
//       final result = await repo.login(event.email, event.password);
//
//       result.fold(
//             (failure) => emit(AuthFailure(failure.message)),
//             (_) => emit(AuthSuccess()),
//       );
//     });
//
//     on<RegisterRequested>((event, emit) async {
//       emit(AuthLoading());
//       final result = await repo.register(
//         event.name,
//         event.email,
//         event.password,
//       );
//
//       result.fold(
//             (failure) => emit(AuthFailure(failure.message)),
//             (_) => emit(AuthSuccess()),
//       );
//     });
//
//     on<LogoutRequested>((event, emit) async {
//       await repo.logout();
//       emit(AuthInitial());
//     });
//   }
// }