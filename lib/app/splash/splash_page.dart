

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eghealthcare/core/themes/app_colors_light.dart';
import 'package:flutter/cupertino.dart';

import '../../core/themes/app_colors_dark.dart';
import '../../core/themes/is_dark_mode.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor:context.isDarkMode? AppColorsDark.background:AppColorsLight.background,
      splashIconSize: double.infinity,
      splashTransition:SplashTransition.scaleTransition ,
      splash:Container(),
      nextScreen: Container(),
      duration: 2000,
      // curve: Curves.easeInToLinear ,
    );
  }
}