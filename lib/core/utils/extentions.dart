extension DateTimeExtension on DateTime {
  String? englishWeekdayName() {
    const Map<int, String> weekdayName = {
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday",
      7: "Sunday"
    };
    return weekdayName[weekday];
  }
}
