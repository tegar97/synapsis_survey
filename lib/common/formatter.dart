import 'package:intl/intl.dart';

String formatDateString(String inputDateStr) {
  DateTime inputDate = DateTime.parse(inputDateStr);
  return DateFormat("d MMM y").format(inputDate);
}
