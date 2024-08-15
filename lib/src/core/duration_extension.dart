extension StringDurationExtension on String {
  Duration get getDurationFromHoursMinutes {
    int hours = 0;
    int minutes = 0;
    List<String> parts = split(':');
    hours = int.parse(parts[0]);
    minutes = int.parse(parts[1]);
    return Duration(hours: hours, minutes: minutes);
  }
}
