import 'package:flutter/cupertino.dart';

class AppGradients {
  static const primary = LinearGradient(
    colors: [Color(0xFF24907F), Color(0xFF2DB4A6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const hero = LinearGradient(
    colors: [Color(0xFF24907F), Color(0xFF1EA7E1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const success = LinearGradient(
    colors: [Color(0xFF2FBF71), Color(0xFF3ED08A)],
  );
}
