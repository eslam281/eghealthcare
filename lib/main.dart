
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/bootstrap/app_bootstrap.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppBootstrap.initialize();

  runApp(const MyApp());
}
