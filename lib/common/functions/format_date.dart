import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat("MMM dd, yyyy, h:mm a"); // Format the date
  return formatter.format(date); // Return the formatted date
}
