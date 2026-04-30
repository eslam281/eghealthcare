import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/appointments_bloc.dart';

class AppointmentsFilterTabs extends StatefulWidget {
 final List<(String, int)> tabs;
   const AppointmentsFilterTabs({super.key, required this.tabs});

  @override
  State<AppointmentsFilterTabs> createState() =>
      _AppointmentsFilterTabsState();
}

class _AppointmentsFilterTabsState
    extends State<AppointmentsFilterTabs> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        widget.tabs.length,
            (index) {

          final isSelected = selectedIndex == index;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  context.read<AppointmentsBloc>().add(ChoiceFilter(index));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),

                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue.withAlpha(25)
                        : Colors.grey.shade100,

                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Text(
                    "${widget.tabs[index].$1} (${widget.tabs[index].$2})",
                    style: TextStyle(
                      color: isSelected
                          ? Colors.blue
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
