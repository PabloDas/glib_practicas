import 'package:intl/intl.dart';

class Utils {
  static const anchoPantallMobile = 900;
  static const anchoPantallTablet = 700;
  static double anchoMenuDesktopOpen = 300;
  static double anchoMenuDesktopClose = 100;

  static String generateId() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyMMddHHmmss');
    final String formatted = formatter.format(now);
    return formatted;
  }

  static bool esMobile(double width) {
    return width < anchoPantallMobile;
  }

  static String currentcyMask(double value) {
    final formatter = NumberFormat.currency(locale: "es_AR", symbol: "");
    return formatter.format(value);
  }

  static bool esEmail(String email) {
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(email);
  }

  static String capitalizeWords(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input
        .split(' ')
        .map((word) => word.isEmpty
            ? ''
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  bool isNumeric(String s) {
    if (s.isEmpty) return false;

    final n = num.tryParse(s);

    return (n == null) ? false : true;
  }

  String getCurrentDateHour() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    final String formatted = formatter.format(now);
    return formatted;
  }

  String getCurrentDate() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(now);
    return formatted;
  }
}
