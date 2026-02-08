import 'package:flutter/material.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const AuthHeader(
                  title: "Welcome Back",
                  subtitle: "Sign in to your EHealthcare account",
                ),
                const SizedBox(height: 24),
                // AuthCard(
                //   child: Column(
                //     children: [
                //       AuthTextField(
                //         hint: "Email Address",
                //         controller: TextEditingController(),
                //       ),
                //       const SizedBox(height: 16),
                //       AuthTextField(
                //         hint: "Password",
                //         isPassword: true,
                //         controller: TextEditingController(),
                //       ),
                //       const SizedBox(height: 20),
                //       AuthButton(
                //         text: "Sign In",
                //         onTap: () {},
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
