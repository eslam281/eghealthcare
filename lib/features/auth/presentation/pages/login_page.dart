import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// استبدل بالمسارات الحقيقية عندك
import '../../../../core/constants/routes.dart';
import '../../../../core/services/role_service.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_text_field.dart';
import '../bloc/auth_bloc.dart'; // تأكد من المسار

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool remember = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AuthBloc(),
  child: Scaffold(
      backgroundColor: const Color(0xffF5F7F6), // خلفية خفيفة زي الصورة
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420), // شكل Web-like
              child: Column(
                children: [
                  const AuthHeader(
                    title: "Welcome Back",
                    subtitle: "Sign in to your EHealthcare account",
                  ),
                  const SizedBox(height: 28),
                  AuthCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AuthTextField(
                          label: "Email Address",
                          hint: "you@example.com",
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        AuthTextField(
                          label: "Password",
                          isPassword: true,
                          controller: passwordCtrl,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: remember,
                                  activeColor: Colors.teal,
                                  onChanged: (v) => setState(() => remember = v ?? false),
                                ),
                                const Text("Remember me"),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.teal),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // BlocConsumer for states
                        BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)));
                            }
                            if (state is AuthSuccess) {
                              // navigate to home
                              Navigator.pushReplacementNamed(context, Routes.patientDashboard);
                            }
                          },
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;
                            return AuthButton(
                              text: isLoading ? "Signing in..." : "Sign In",
                              enabled: !isLoading,
                              onTap: isLoading
                                  ? null
                                  : () {
                                // Validation بسيطة قبل الإرسال
                                if (emailCtrl.text.trim().isEmpty ||
                                    passwordCtrl.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please fill all fields')),
                                  );
                                  return;
                                }

                                context.read<AuthBloc>().add(
                                  LoginRequested(
                                    emailCtrl.text.trim(),
                                    passwordCtrl.text,
                                    UserRole.patient,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
);
  }
}
