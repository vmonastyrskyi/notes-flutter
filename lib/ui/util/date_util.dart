import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final differenceInDays = DateTime.now().difference(date).inDays;

  if (differenceInDays == 0) {
    // 23:59
    return '${DateFormat('kk:mm').format(date)}';
  } else if (differenceInDays == 1) {
    // Yesterday 23:59
    return 'Yesterday ${DateFormat('kk:mm').format(date)}';
  } else if (differenceInDays > 1 && differenceInDays <= 7) {
    // Sun 23:59
    return '${DateFormat('E kk:mm').format(date)}';
  } else {
    // 01 Jan 23:59
    return '${DateFormat('dd MMM kk:mm').format(date)}';
  }
}