import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String formatDate(String inputDate) {
  initializeDateFormatting('id_ID', null);
  final parsedDate = DateTime.parse(inputDate);
  final formatter = DateFormat.yMMMMd('id_ID');
  final formattedDate = formatter.format(parsedDate);
  return formattedDate;
}
