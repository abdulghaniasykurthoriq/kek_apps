// import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

String countAge(String inputDate) {
  initializeDateFormatting('id_ID', null);
  final parsedDate = DateTime.parse(inputDate).year;
  final age = DateTime.now().year - parsedDate;
  return age.toString();
}
