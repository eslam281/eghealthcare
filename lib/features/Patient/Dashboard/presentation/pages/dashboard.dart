import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../auth/presentation/bloc/auth_bloc.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_stats_row.dart';
import '../../../../../core/shared/drawer.dart';
import '../widgets/drawer_body.dart';
import '../widgets/featured_doctors_section.dart';
import '../widgets/upcoming_appointments_section.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(LoadDashboardRequested()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context,stat) {
                  if(stat is DashboardLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Welcome back,${stat.user.fullName!}"),
                        ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(50),
                          child: CircleAvatar(
                            child: stat.user.imageURL != null
                                ? CachedNetworkImage(imageUrl:stat.user.imageURL!)
                                : const Icon(Icons.person),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                }
              ),
            ),

            floatingActionButton: FloatingActionButton(onPressed: () {
              // context.read<AuthBloc>().add(
              //   GetUserRequested(),
              // );
              // context.read<AuthBloc>().add(
              //   LogoutRequested(),
              // );
            }, shape: const CircleBorder(),
              child: const Icon(Icons.support_agent,
                color: Colors.white,),),

            drawer: const AppDrawer(body: DrawerBody(),),

            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none), label: "Alerts"),
              ],
            ),

            body: const _DashboardBody(),
          );
        }
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody();

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
                FeaturedDoctorsSection(doctors: state.featuredDoctors),
                const SizedBox(height: 30),
              ],
            ),
          );
        }

        return const Center(child: Text("Something went wrong"));
      },
    );
  }
}
