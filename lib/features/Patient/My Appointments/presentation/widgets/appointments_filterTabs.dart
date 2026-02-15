import 'package:flutter/material.dart';

class AppointmentsFilterTabs extends StatefulWidget {
  const AppointmentsFilterTabs({super.key});

  @override
  State<AppointmentsFilterTabs> createState() =>
      _AppointmentsFilterTabsState();
}

class _AppointmentsFilterTabsState
    extends State<AppointmentsFilterTabs> {

  int selectedIndex = 0;

  final tabs = const [
    ("Scheduled", 3),
    ("Completed", 1),
    ("Cancelled", 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        tabs.length,
            (index) {

          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });

                /// هنا بعد كده تنادي Bloc
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
                  "${tabs[index].$1} (${tabs[index].$2})",
                  style: TextStyle(
                    color: isSelected
                        ? Colors.blue
                        : Colors.grey,
                    fontWeight: FontWeight.w500,
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
