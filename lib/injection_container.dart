
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eghealthcare/features/Appointments/data/source/appointmentApi.dart';
import 'package:eghealthcare/features/Doctor/Dashboard/domain/repository/dashboard_repository.dart';
import 'package:eghealthcare/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import 'app/routes/app_initial_route.dart';
import 'core/network/api_client.dart';
import 'core/network/network_call_handler.dart';
import 'core/network/network_info.dart';
import 'core/services/cipher_key.dart';
import 'core/services/role_service.dart';
import 'features/Doctor/Dashboard/data/repository/dashboard_repository.dart';
import 'features/Doctor/Dashboard/data/source/DashboardApi.dart';
import 'features/Doctor/Dashboard/domain/usecases/getAppointment_usecase.dart';
import 'features/Doctor/Dashboard/domain/usecases/getUser_usecase.dart';
import 'features/Patient/Dashboard/data/repository/dashboard_repository.dart';
import 'features/Patient/Dashboard/data/source/DashboardApi.dart';
import 'features/Patient/Dashboard/domain/repository/dashboard_repository.dart';
import 'features/Patient/Dashboard/domain/usecases/getAppointment_usecase.dart';
import 'features/Patient/Dashboard/domain/usecases/getDoctor_usecases.dart';
import 'features/Patient/Dashboard/domain/usecases/getUser_usecase.dart';
import 'features/auth/data/source/auth_firebase_service.dart';
import 'features/auth/domain/repository/auth_reepository.dart';
import 'features/auth/domain/usecases/signin.dart';
import 'features/auth/domain/usecases/signin_Google.dart';
import 'features/auth/domain/usecases/signout.dart';
import 'features/auth/domain/usecases/signup.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  _initExternal();
  _initServices();
  _initCore();
  _initSource();
  _initRepository();
  _initUseCase();
}

void _initExternal() {
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
}

void _initServices() {
  sl.registerLazySingleton<EncryptionKeyService>(() => EncryptionKeyServiceImpl(sl()));
  sl.registerLazySingleton<RoleService>(() => RoleServiceImpl(sl()));
}
void _initSource() {
  sl.registerLazySingleton<AuthFirebaseService>(() => AuthFirebaseServiceImpl());
  sl.registerLazySingleton<AppointmentApi>(() => AppointmentApiImpl());
  ////////////////////////////////////////
  sl.registerLazySingleton<PDashboardApi>(() => PDashboardApiImpl());
  ///////////////////////////////////////
  sl.registerLazySingleton<DocDashboardApi>(() => DocDashboardApiImpl());

}

void _initCore() {
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<Client>(() => Client());
  sl.registerLazySingleton<AppStartDecider>(() => AppStartDecider(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<NetworkCallHandler>(() => NetworkCallHandler(sl()));
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(sl()));
}

void _initRepository() {
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());
  ////////////////////////////
  sl.registerLazySingleton<PDashboardRepository>(() => PDashboardRepositoryImpl());
  ////////////////////////////////
  sl.registerLazySingleton<DocDashboardRepository>(() => DocDashboardRepositoryImpl());
}

void _initUseCase() {
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase());
  sl.registerLazySingleton<SingUpUseCase>(() => SingUpUseCase());
  sl.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase());
  sl.registerLazySingleton<SignInGoogleUseCase>(() => SignInGoogleUseCase());
  ///////////////////////////////////
  sl.registerLazySingleton<PGetUserUseCase>(() => PGetUserUseCase());
  sl.registerLazySingleton<GetPatientAppointmentUseCase>(() => GetPatientAppointmentUseCase());
  //////////////////////////////////
  sl.registerLazySingleton<GetDoctorsUseCases>(() => GetDoctorsUseCases());
  sl.registerLazySingleton<DocGetUserUseCase>(() => DocGetUserUseCase());
  sl.registerLazySingleton<GetDocAppointmentUseCase>(() => GetDocAppointmentUseCase());
}
