import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared/drawer.dart';
import '../../../../../core/shared/floating_action_button.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/Drawer_body.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_stats_row.dart';
import '../widgets/patients_section.dart';
import '../widgets/upcoming_appointments_section.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc()..add(LoadDashboardRequested()),
      child: Scaffold(
        appBar:  AppBar(
          title: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context,stat) {
                if(stat is DashboardLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Text("Dr.",style:TextStyle(color:Theme.of(context).colorScheme.primary )),
                        Text("${stat.user.fullName}"),
                      ],),

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
        drawer: const AppDrawer(body: DrawerBody(),),
        floatingActionButton: const FloatingAction(),

        body: const _DashboardBody(),
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
                const SizedBox(height: 20),
                PatientsSection(
                  patients: state.patients, // من البلوك
                ),
                //نصيحه من شات جبتي لو حابب تحسن شكل ديزاين
                // Container(
                //   padding: EdgeInsets.all(20),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20),
                //     boxShadow: [
                //       BoxShadow(
                //         blurRadius: 20,
                //         color: Colors.black.withOpacity(.05),
                //       ),
                //     ],
                //   ),
                // )

              ],
            ),
          );
        }

        return const Center(child: Text("Something went wrong"));
      },
    );
  }
}