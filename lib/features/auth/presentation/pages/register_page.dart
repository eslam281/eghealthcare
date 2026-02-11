import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/services/role_service.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_button.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_header.dart';
import '../widgets/auth_role_selector.dart';
import '../widgets/auth_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  bool isAgree = false;
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
                      title: "Create Account",
                      subtitle: "Join EGhealthcare today",
                    ),
                    const SizedBox(height: 28),
                    AuthCard(
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AuthTextField(
                              label: "Full Name",
                              hint: "John Doe",
                              controller: nameCtrl,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Full name is required";
                                }
                                if (value.length < 3) {
                                  return "Name is too short";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
                            AuthTextField(
                              label: "Confirm Password",
                              isPassword: true,
                              controller: confirmPasswordCtrl,
                              validator: (value) {
                                if (value != passwordCtrl.text) {
                                  return "Passwords do not match";
                                }
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
                                      value: isAgree,
                                      activeColor: Colors.teal,
                                      onChanged: (v) =>
                                          setState(() => isAgree = v ?? false),
                                    ),
                                    const Text("I agree to the Terms of Service and Privacy Policy"),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // BlocConsumer for states
                            BlocConsumer<AuthBloc, AuthState>(
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
                                builder: (context, state) {
                                  final isLoading = state is AuthLoading;

                                  return AuthButton(
                                    text: isLoading
                                        ? "Create Account..." : "Sign UP",
                                    enabled: !isLoading,
                                    onTap: isLoading
                                        ? null
                                        : () {
                                      final isValid = _formKey.currentState!.validate();
                                      if (!isValid) return;

                                      if (!isAgree) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Please agree to Terms'),
                                          ),
                                        );
                                        return;
                                      }

                                      context.read<AuthBloc>().add(
                                        RegisterRequested(
                                          nameCtrl.text,
                                          emailCtrl.text.trim(),
                                          passwordCtrl.text,
                                          _role,
                                        ),
                                      );
                                    },
                                  );
                                },
                            )

                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.login,
                              );
                            },
                            child: const Text(
                              "Sign in here",
                              style: TextStyle(color: Colors.teal),
                            ),
                          )
                        ]),
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
