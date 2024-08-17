extension DateTimeExtensions on DateTime {
  bool isSameDay(DateTime other) =>
      day == other.day && month == other.month && year == other.year;

  bool isBetweenRangeInDays(DateTime from, DateTime to) {
    return isBefore(
          DateTime(from.year, from.month, from.day, 23, 59),
        ) &&
        isAfter(
          DateTime(to.year, to.month, to.day, 0, 0),
        );
  }
}
