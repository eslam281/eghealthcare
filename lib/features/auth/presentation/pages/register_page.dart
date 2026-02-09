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
import '../widgets/social_login_section.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthTextField(
                            label: "Full Name",
                            hint: "John Doe",
                            controller: nameCtrl,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 16),
                          AuthTextField(
                            label: "Confirm Password",
                            isPassword: true,
                            controller: confirmPasswordCtrl,
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
                                  context,
                                  Routes.patientDashboard,
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
                                    if (emailCtrl.text.trim().isEmpty || passwordCtrl.text.isEmpty ||
                                        nameCtrl.text.isEmpty
                                    ) {
                                      ScaffoldMessenger.of(context,).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please fill all fields',),),);
                                      return;
                                    }
                                    if(!isAgree){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please agree to the Terms of Service and Privacy Policy',),),);
                                      return;
                                    }
                                    if (passwordCtrl.text != confirmPasswordCtrl.text) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Passwords do not match',),),);
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
                    const SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.register,
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
