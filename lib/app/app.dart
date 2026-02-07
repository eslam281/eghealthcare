import 'package:eghealthcare/app/routes/app_routes.dart';
import 'package:eghealthcare/app/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/themes/app_themes.dart';
import '../core/themes/theme_cubit.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            title: 'EGhealthcare',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,
            routes: routes,
            // home: const SplashScreen(),
          );
        },
      ),
    );
  }
}