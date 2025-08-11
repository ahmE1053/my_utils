extension DateTimeExtensions on DateTime {
  bool isSameDay(DateTime other) =>
      day == other.day && month == other.month && year == other.year;

  bool isBetweenRangeInDays(DateTime from, DateTime to) {
    final startOfFromDay = DateTime(from.year, from.month, from.day);
    final endOfToDay = DateTime(to.year, to.month, to.day, 23, 59, 59);

    return isAfter(startOfFromDay) && isBefore(endOfToDay);
  }
}
