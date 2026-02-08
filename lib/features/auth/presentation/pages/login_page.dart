import 'package:flutter/material.dart';

import '../widgets/auth_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                AuthCard(
                  child: Column(
                    children: [
                      AuthTextField(
                        hint: "Email Address",
                        controller: TextEditingController(),
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        hint: "Password",
                        isPassword: true,
                        controller: TextEditingController(),
                      ),
                      const SizedBox(height: 20),
                      AuthButton(
                        text: "Sign In",
                        onTap: () {},
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (_) {}),
                              const Text("Remember me"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(color: Colors.teal),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
