
import 'package:flutter/material.dart';

import '../features/Patient/Dashboard/presentation/pages/dashboard.dart';

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