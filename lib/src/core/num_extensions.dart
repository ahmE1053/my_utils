extension Range<T extends double> on num {
  T getRangeFromAnotherRange(T oldMin, T oldHigh, T newMin, T newHigh) {
    T newValue = ((this - oldMin) / (oldHigh - oldMin) * (newHigh - newMin) +
        newMin) as T;
    return newValue;
  }

  T getRangeFromZeroToOne(T min, T high) {
    T newValue = ((this - 0.0) / (1.0 - 0.0) * (high - min) + min) as T;
    return newValue;
  }

  double newSizeBasedOnTextScale({
    required double textScale,
  }) {
    if (textScale == 1) return toDouble();
    if (textScale < 1) {
      return this - (this * textScale * 0.1);
    }
    if (textScale > 1.5) {
      return this + (this * textScale * 0.2);
    }
    return this + (this * textScale * 0.1);
  }

  String get durationFormatter {
    var seconds = this ~/ 1000;
    final hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;
    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';
    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';
    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';
    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';
    return formattedTime;
  }
}

extension DurationExtension on int {
  String get getDurationFromMinutesArabic {
    int mins = this % 60;
    int hours = this ~/ 60;
    StringBuffer result = StringBuffer();
    if (hours == 1) {
      result.write('ساعة');
    } else if (hours == 2) {
      result.write('ساعتين');
    } else if (hours <= 10 && hours != 0) {
      result.write('$hours ساعات');
    } else if (hours != 0) {
      result.write('$hours ساعة');
    }
    if (result.isNotEmpty && mins > 0) {
      result.write(' و ');
    }
    if (mins == 1) {
      result.write('دقيقة');
    } else if (mins == 2) {
      result.write('دقيقتين');
    } else if (mins <= 10 && mins != 0) {
      result.write('$mins دقايق');
    } else if (mins != 0) {
      result.write('$mins دقيقة');
    }
    return result.toString();
  }

  String get getDurationFromMinutesEnglish {
    int mins = this % 60;
    int hours = this ~/ 60;
    StringBuffer result = StringBuffer();
    if (hours == 1) {
      result.write('Hour');
    } else if (hours != 0) {
      result.write('$hours Hours');
    }
    if (result.isNotEmpty && mins > 0) {
      result.write(', ');
    }
    if (mins == 1) {
      result.write('Minute');
    } else if (mins != 0) {
      result.write('$mins Minutes');
    }
    return result.toString();
  }
}
