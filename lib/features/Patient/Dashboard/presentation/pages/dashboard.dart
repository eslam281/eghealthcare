import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_stats_row.dart';
import '../widgets/upcoming_appointments_section.dart';

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
            }, shape: const CircleBorder(),
              child: const Icon(LucideIcons.messageCircle, color: Colors.white,),),

            drawer: const Placeholder(),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none), label: "Alerts"),
              ],
            ),
            body: const DashboardView(),
          );
        }
      ),
    );
  }
}
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardBloc()..add(LoadDashboardRequested()),
      child: const DashboardBody(),
    );
  }
}
class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is DashboardLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardHeader(user: state.user),
                const SizedBox(height: 20),
                DashboardStatsRow(summary: state.summary),
                const SizedBox(height: 24),
                UpcomingAppointmentsSection(
                  appointments: state.upcomingAppointments,
                ),
              ],
            ),
          );
        }

        return const Center(child: Text("Something went wrong"));
      },
    );
  }
}
