
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';


import 'core/configs/app_configs.dart';
import 'core/services/cipher_key.dart';
import 'features/Patient/Dashboard/presentation/pages/dashboard.dart';
import 'injection_container.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const envString = String.fromEnvironment('ENV', defaultValue: 'dev');
  final env = getEnvironmentFromString(envString);
  AppConfig.initialize(env);

  await initializeDependencies();

  final encryptionKey = await cipherKey();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path,),
    encryptionCipher: HydratedAesCipher(encryptionKey),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EGhealthcare',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Dashboard(),
    );
  }
}