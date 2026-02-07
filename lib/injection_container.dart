
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'app/routes/app_initial_route.dart';
import 'core/services/cipher_key.dart';
import 'core/services/role_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  _initExternal();
  _initServices();
}

void _initExternal() {
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
}

void _initServices() {
  sl.registerLazySingleton<EncryptionKeyService>(() => EncryptionKeyServiceImpl(sl()));
  sl.registerLazySingleton<RoleService>(() => RoleServiceImpl(sl()));
}

void _initCore() {
  sl.registerLazySingleton<AppStartDecider>(() => AppStartDecider(sl()));
}
