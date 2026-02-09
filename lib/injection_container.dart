
import 'package:eghealthcare/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'app/routes/app_initial_route.dart';
import 'core/services/cipher_key.dart';
import 'core/services/role_service.dart';
import 'core/usecase/usecase.dart';
import 'features/auth/data/source/auth_firebase_service.dart';
import 'features/auth/domain/repository/auth_reepository.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/domain/usecases/signin.dart';
import 'features/auth/domain/usecases/signin_Google.dart';
import 'features/auth/domain/usecases/signout.dart';
import 'features/auth/domain/usecases/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  _initExternal();
  _initServices();
  _initCore();
  _initRepository();
  _initUseCase();
}

void _initExternal() {
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
}

void _initServices() {
  sl.registerLazySingleton<EncryptionKeyService>(() => EncryptionKeyServiceImpl(sl()));
  sl.registerLazySingleton<RoleService>(() => RoleServiceImpl(sl()));
  sl.registerLazySingleton<AuthFirebaseService>(() => AuthFirebaseServiceImpl());

}

void _initCore() {
  sl.registerLazySingleton<AppStartDecider>(() => AppStartDecider(sl()));
}

void _initRepository() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
}

void _initUseCase() {
  sl.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase());
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase());
  sl.registerLazySingleton<SingUpUseCase>(() => SingUpUseCase());
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase());
  sl.registerLazySingleton<SignInGoogleUseCase>(() => SignInGoogleUseCase());
}
