class WeekdayUtility {
  static const List<String> weekdayTextKey = <String>[
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  static String getWeekdayKeyByIndex(int index) {
    return weekdayTextKey.asMap()[index];
  }
}
