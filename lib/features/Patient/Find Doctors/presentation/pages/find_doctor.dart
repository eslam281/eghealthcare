import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/book_appointment_bloc.dart';
import '../bloc/find_doctor_bloc.dart';
import '../widgets/doctor_card.dart';

class FindDoctorsPage extends StatelessWidget {
  const FindDoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocProvider(
      create: (context) => BookAppointmentBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Find a Doctor",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => FindDoctorBloc()..add(LoadDoctorRequested()),
          child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: Text(
                    "Browse our network of qualified healthcare professionals",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// Search + Filter Row
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search by name or specialty...",
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: colors.surfaceContainerHighest,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: Row(
                          children: [
                            const Icon(Icons.filter_list),
                            const SizedBox(width: 8),
                            DropdownButton(
                              value: "All",
                              items: const [
                                DropdownMenuItem(
                                  value: "All",
                                  child: Text("All Specialties"),
                                ),
                                DropdownMenuItem(
                                  value: "All2",
                                  child: Text("CS"),
                                ),
                                DropdownMenuItem(
                                  value: "All3",
                                  child: Text("OS"),
                                ),
                              ],
                              onChanged: (value) {

                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 24),

                /// Doctors Grid
                BlocBuilder<FindDoctorBloc, FindDoctorState>(
                  builder: (context, state) {
                   if(state is FindDoctorLoading){
                     return const Center(child: CircularProgressIndicator());
                   }
                   if(state is FindDoctorLoaded){
                     return Expanded(
                       child: ListView.separated(
                         padding: const EdgeInsets.only(top: 16, bottom: 24),
                         itemCount: state.doctors.length,
                         separatorBuilder: (context, index) =>
                         const SizedBox(height: 16),
                         itemBuilder: (context, index) =>
                             DoctorCard(doctor: state.doctors[index],),
                       ),
                     );
                   }
                   if(state is FindDoctorError){
                     return Center(child: Text(state.message));
                   }
                   return const SizedBox();
                  },
                )
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}
