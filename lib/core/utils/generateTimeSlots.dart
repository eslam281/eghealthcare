List<String> generateTimeSlots(String from, String to) {
  List<String> slots = [];

  DateTime start = parseTime(from);
  DateTime end = parseTime(to);

  while (start.isBefore(end)) {
    slots.add(
      "${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}",
    );

    start = start.add(const Duration(minutes: 30));
  }

  return slots;
}
DateTime parseTime(String time) {
  final now = DateTime.now();
  final parts = time.split(":");

  return DateTime(
    now.year,
    now.month,
    now.day,
    int.parse(parts[0]),
    int.parse(parts[1]),
  );
}