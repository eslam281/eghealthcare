import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailabilityPicker extends StatefulWidget {
  final Function(List<Map<String, String>>) onChanged;

  const AvailabilityPicker({
    super.key,
    required this.onChanged,
  });

  @override
  State<AvailabilityPicker> createState() => _AvailabilityPickerState();
}

class _AvailabilityPickerState extends State<AvailabilityPicker> {
  final List<Map<String, String>> availability = [];

  final days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String selectedDay = 'Monday';
  TimeOfDay? fromTime;
  TimeOfDay? toTime;

  String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedDay,
          items: days
              .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
              .toList(),
          onChanged: (v) {
            setState(() {
              selectedDay = v!;
            });
          },
        ),

        Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (time != null) {
                  setState(() {
                    fromTime = time;
                  });
                }
              },
              child: Text(
                fromTime == null
                    ? 'From'
                    : formatTime(fromTime!),
              ),
            ),

            const SizedBox(width: 10),

            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (time != null) {
                  setState(() {
                    toTime = time;
                  });
                }
              },
              child: Text(
                toTime == null
                    ? 'To'
                    : formatTime(toTime!),
              ),
            ),
          ],
        ),

        ElevatedButton(
          onPressed: () {
            if (fromTime == null || toTime == null) return;

            availability.add({
              "day": selectedDay,
              "from": formatTime(fromTime!),
              "to": formatTime(toTime!),
            });

            widget.onChanged(availability);

            setState(() {});
          },
          child: const Text("Add"),
        ),

        const SizedBox(height: 10),

        ...availability.map(
              (e) => ListTile(
            title: Text(e['day']!),
            subtitle: Text(
              '${e['from']} - ${e['to']}',
            ),
          ),
        ),
      ],
    );
  }
}