import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// استبدل بالمسارات الحقيقية عندك
import '../../../../core/constants/routes.dart';
import '../../../../core/services/role_service.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_role_selector.dart';
import '../widgets/auth_text_field.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/social_login_section.dart'; // تأكد من المسار

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool remember = false;
  late UserRole _role = UserRole.patient;

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
                constraints: const BoxConstraints(maxWidth: 420),
                // شكل Web-like
                child: Column(
                  children: [
                    const AuthHeader(
                      title: "Welcome Back",
                      subtitle: "Sign in to your EHealthcare account",
                    ),
                    const SizedBox(height: 28),
                    AuthCard(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AuthTextField(
                              label: "Email Address",
                              hint: "you@example.com",
                              controller: emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Email is required";
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            AuthTextField(
                              label: "Password",
                              isPassword: true,
                              controller: passwordCtrl,
                              validator: (value) {
                                if (value == null || value.isEmpty) return "Password is required";
                                if (value.length < 6) return "Password must be at least 6 characters";
                                return null;
                              },
                            ),
                            const SizedBox(height: 18),
                            RoleSelector(
                              selectedRole: _role,
                              onChanged: (role) {
                                setState(() {
                                  _role = role;
                                });
                              },
                            ),

                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: remember,
                                      activeColor: Colors.teal,
                                      onChanged: (v) =>
                                          setState(() => remember = v ?? false),
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
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is AuthFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }

                            if (state is AuthSuccess) {
                              Navigator.pushReplacementNamed(
                                context,_role==UserRole.patient?
                              Routes.patientDashboard:Routes.doctorDashboard
                              );
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              final isLoading = state is AuthLoading;

                              return Column(
                                children: [
                                  AuthButton(
                                    text: isLoading ? "Signing in..." : "Sign In",
                                    enabled: !isLoading,
                                    onTap: isLoading
                                        ? null
                                        : () {
                                      final isValid = _formKey.currentState!.validate();
                                      if (!isValid) return;

                                      context.read<AuthBloc>().add(
                                        LoginRequested(
                                          emailCtrl.text.trim(),
                                          passwordCtrl.text,
                                          _role,
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  /// 🔹 Google Button
                                  SocialLoginSection(
                                    onGooglePressed: () {
                                      context.read<AuthBloc>().add(
                                        GoogleSignInRequested(_role,),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        ],),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.register,
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.teal),
                          ),
                        )
                          ]),
                    ],),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
