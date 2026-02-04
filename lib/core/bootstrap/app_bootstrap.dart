import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../injection_container.dart';
import '../configs/app_configs.dart';
import '../services/cipher_key.dart';

class AppBootstrap {
  static Future<void> initialize() async {
    const envString = String.fromEnvironment('ENV', defaultValue: 'dev');
    final env = getEnvironmentFromString(envString);
    AppConfig.initialize(env);

    await initializeDependencies();

    final encryptionKey = await sl<EncryptionKeyService>().getKey();

    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(
        (await getApplicationDocumentsDirectory()).path,
      ),
      encryptionCipher: HydratedAesCipher(encryptionKey),
    );
  }
}
