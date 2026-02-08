import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../../firebase_options.dart';
import '../../injection_container.dart';
import '../configs/app_configs.dart';
import '../services/cipher_key.dart';

class AppBootstrap {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
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
