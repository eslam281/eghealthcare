import 'package:eghealthcare/app/splash/splash_cubit.dart';
import 'package:eghealthcare/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/constants/routes.dart';
import '../../core/themes/app_colors_dark.dart';
import '../../core/themes/app_colors_light.dart';
import '../../core/themes/app_gradients.dart';
import '../../core/themes/is_dark_mode.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(sl())..checkAppStart(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is GoToLogin) {
            Navigator.pushReplacementNamed(context, Routes.login);
          } else if (state is GoToPatientHome) {
            Navigator.pushReplacementNamed(context, Routes.patientDashboard);
          } else if (state is GoToDoctorHome) {
            Navigator.pushReplacementNamed(context, Routes.doctorDashboard);
          }
        },
        child: Scaffold(
          backgroundColor: context.isDarkMode ? AppColorsDark.background : AppColorsLight.background,
          body: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColorsLight.primary,
                  ),
                  child: const Center(
                    child: Icon(
                      LucideIcons.stethoscope,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(text: 'EG'),
                      TextSpan(
                        text: 'healthcare',
                        style: TextStyle(color:AppColorsLight.primary,
                            fontWeight:FontWeight.bold ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )

        ),
      ),
    );
  }
}
