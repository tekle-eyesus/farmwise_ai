import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String formatReadable(DateTime dateTime) {
    final formatter = DateFormat('MMM d, yyyy • h:mm a');
    return formatter.format(dateTime);
  }
}
