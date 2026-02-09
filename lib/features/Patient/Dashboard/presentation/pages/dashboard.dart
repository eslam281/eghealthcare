import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../auth/presentation/bloc/auth_bloc.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Welcome back, John"), CircleAvatar(),
                ],
              ),
            ),

            floatingActionButton: FloatingActionButton(onPressed: () {
              // context.read<AuthBloc>().add(
              //   GetUserRequested(),
              // );
              context.read<AuthBloc>().add(
                LogoutRequested(),
              );
            }, shape: CircleBorder(), backgroundColor: Colors.green,
              child: Icon(LucideIcons.messageCircle, color: Colors.white,),),

            drawer: Placeholder(),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none), label: "Alerts"),
              ],
            ),
            body: Placeholder(),
          );
        }
      ),
    );
  }
}
