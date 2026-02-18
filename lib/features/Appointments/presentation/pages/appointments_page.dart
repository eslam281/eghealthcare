import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/appointments_bloc.dart';
import '../widgets/appointment_card.dart' show AppointmentCard;
import '../widgets/appointments_filterTabs.dart';
import '../widgets/appointments_statsRow.dart';

class MyAppointmentsPage extends StatelessWidget {
  const MyAppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointmentsBloc()..add(LoadAppointments()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Appointments",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<AppointmentsBloc, AppointmentsState>(
          builder: (context, state) {
            if (state is AppointmentsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AppointmentsError) {
              return Center(child: Text(state.message));
            }
            if (state is AppointmentsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                const Center(
                  child: Text(
                  "Manage and track all your medical appointments",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),),
                ),
        
                  const SizedBox(height: 16),
        
                  /// Stats
                  const AppointmentsStatsRow(),
        
                  const SizedBox(height: 16),
        
                  /// Tabs
                  const AppointmentsFilterTabs(),
        
                  const SizedBox(height: 16),
        
                  /// هنا تحط appointment cards بتاعتك القديمة
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.upcomingAppointments.length,
                    itemBuilder:(context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: AppointmentCard(
                          appointment: state.upcomingAppointments[index],
                        ),
                      );
                    },
                  ),
        
                ],
              );
            }
            return Container();
        
          },
        ),
      ),
    );
  }
}
