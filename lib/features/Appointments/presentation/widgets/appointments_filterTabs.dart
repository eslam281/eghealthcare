import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/appointments_bloc.dart';

class AppointmentsFilterTabs extends StatelessWidget {
  final Map<AppointmentFilter, int> counts;

  final AppointmentFilter selectedFilter;

  const AppointmentsFilterTabs({
    super.key,
    required this.counts,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    const filters = AppointmentFilter.values;

    return Row(
      children: List.generate(filters.length, (index) {
        final filter = filters[index];

        final isSelected = selectedFilter == filter;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),

            child: GestureDetector(
              onTap: () {
                context.read<AppointmentsBloc>().add(ChoiceFilter(filter));
              },

              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.withAlpha(25) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.transparent,
                  ),
                ),

                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("${filter.title} (${counts[filter] ?? 0})",
                    style: TextStyle(color: isSelected ? Colors.blue : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
