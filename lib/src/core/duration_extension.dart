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

extension DurationExtension on Duration {
  String get format {
    final hours = inHours > 0 ? inHours.toString().padLeft(2, '0') : null;
    final minutes = inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${hours == null ? '' : '$hours:'}$minutes:$seconds';
  }
}
