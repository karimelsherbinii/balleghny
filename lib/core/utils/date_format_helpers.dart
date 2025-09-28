import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// Method to format appointment date
String formatDate(String rawDate,
    {bool withOutDayNameAnYear = false,
    String separator = '/',
    bool hasOneLine = false}) {
  initializeDateFormatting("ar_SA", '');
  var rawDateSwgments = rawDate.split(separator).toList();
  var dateObject = DateTime(
    int.parse(rawDateSwgments[2]),
    int.parse(rawDateSwgments[1]),
    int.parse(rawDateSwgments[0]),
  );
  var formatter = withOutDayNameAnYear
      ? DateFormat.MMMMd('ar_SA')
      : DateFormat.MMMMEEEEd('ar_SA');
//     var formatter = DateFormat.yMMMd('ar_SA');
  print(formatter.locale);
  String formatted = formatter.format(dateObject);

  formatted = formatted.replaceAll('، ', !hasOneLine ? '\n' : ' ');
  return formatted;
}

String getDayNameFromDate(String dateStr, String languageTag) {
  String dayName = "";
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  try {
    DateTime dateTime = dateFormat.parse(dateStr);
    dayName = DateFormat('EEEE', languageTag).format(dateTime);
    return dayName;
  } catch (e) {
    return dayName;
  }
}

String getDateInSpecificFormat(DateTime date, String format) {
  try {
    return DateFormat(format).format(date);
  } catch (e) {
    return "";
  }
}

DateTime getDateFromString(String dateStr) {
  try {
    return DateTime.parse(dateStr);
  } catch (e) {
    return DateTime.now();
  }
}
