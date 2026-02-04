
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'core/services/cipher_key.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async{
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton<EncryptionKeyService>(
        () => EncryptionKeyServiceImpl(sl()),
  );

}