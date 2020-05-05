import 'package:intl/intl.dart';

class TimeUtility {
  static const int SINGLE_MIN_ANGLE = 6, CIRCLE_MAX_DEGREE = 360, MIN_IN_HOURS = 60;
  static const String ZERO_PAD_12HOUR_MIN_PATTERN = 'hh:mm',
      ZERO_PAD_24HOUR_MIN_PATTERN = 'HH:mm',
      DAY_AND_HOUR_MIN_PATTERN = 'EEE HH:mm',
      ISO8601_NO_MS = 'yyyy-MM-ddTHH:mm:ss',
      ZERO_PAD_HOUR_MIN_DAYTIME_PATTERN = 'hh:mm a',
      AM_PM_MARKER_PATTERN = 'a',
      DAY_EEE_PATTERN = 'EEE';

  static String format(DateTime dateTime, {String pattern = ZERO_PAD_12HOUR_MIN_PATTERN}) {
    return DateFormat(pattern).format(dateTime ?? DateTime.now());
  }

  static DateTime parse(String dateTime, {String pattern = ISO8601_NO_MS}) {
    return DateFormat(pattern).parse(dateTime ?? '');
  }

  static String parseAndFormat(String dateTime,
      {String parsePattern = ISO8601_NO_MS, String formatPattern = ZERO_PAD_12HOUR_MIN_PATTERN}) {
    return format(parse(dateTime, pattern: parsePattern), pattern: formatPattern);
  }

  /// Converts angles to minutes
  static double angleToMin(double angle) => angle / SINGLE_MIN_ANGLE;

  static int convertMinsToHours(int minutes) => minutes ~/ MIN_IN_HOURS;

  static int convertMinsToMinInHour(int minutes) => minutes % MIN_IN_HOURS;

  /// Converts [minutes] to hours and returns string hours with additional pad on the left
  static String getFormattedHoursStringFromMin(double minutes) =>
      convertMinsToHours(minutes.round()).toString().padLeft(2, '0');

  /// Converts [minutes] to mins in range from 0-59 and returns string minutes with additional pad on the left
  static String getFormattedMinsStringFromMin(double minutes) =>
      convertMinsToMinInHour(minutes.round()).toString().padLeft(2, '0');

  /// Converts [angle] and returns string hours with additional pad on the left
  static String getFormattedHoursStringFromTimerAngle(int angle) => getFormattedHoursStringFromMin(
        angleToMin(
          angle?.toDouble(),
        ),
      );

  /// Converts [angle] and returns string minutes with additional pad on the left
  static String getFormattedMinsStringFromTimerAngle(int angle) => getFormattedMinsStringFromMin(
        angleToMin(
          angle?.toDouble(),
        ),
      );
}
