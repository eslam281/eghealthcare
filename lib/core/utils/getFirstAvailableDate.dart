DateTime getFirstAvailableDate(Set<int> availableDays) {
  DateTime date = DateTime.now();

  for (int i = 0; i < 30; i++) {
    if (availableDays.contains(date.weekday)) {
      return date;
    }
    date = date.add(const Duration(days: 1));
  }

  return DateTime.now(); // fallback
}