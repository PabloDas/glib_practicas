import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // SINGLETON
  static final AppPreferences _instancia = AppPreferences._internal();

  factory AppPreferences() {
    return _instancia;
  }

  AppPreferences._internal();

  // MAIN PROPIEDAD
  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // FirebaseAuth auth = FirebaseAuth.instance;

  cleanLocalStorage() {
    _prefs.clear();
  }

  String get usuario_id => _prefs.getString('usuario_id') ?? '';
  set usuario_id(String value) => _prefs.setString('usuario_id', value);

  String get usuario_email => _prefs.getString('usuario_email') ?? '';
  set usuario_email(String value) =>
      _prefs.setString('usuario_email', value);

  String get usuario_nombre => _prefs.getString('usuario_nombre') ?? '';
  set usuario_nombre(String value) =>
      _prefs.setString('usuario_nombre', value);

  String get usuario_tipo => _prefs.getString('usuario_tipo') ?? '';
  set usuario_tipo(String value) =>
      _prefs.setString('usuario_tipo', value);
}
