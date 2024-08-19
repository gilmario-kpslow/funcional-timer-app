import 'package:shared_preferences/shared_preferences.dart';

enum Preferencia {
  tempo,
  programacao;
}

class PreferenciaService {
  late SharedPreferences _preferences;

  void initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<String> getValue(Preferencia key) async {
    // ignore: unnecessary_null_comparison
    if (_preferences == null) {
      initPreferences();
    }
    dynamic value = _preferences.getString(key.name);
    return value;
  }

  Future<void> setValue(String value, Preferencia key) async {
    initPreferences();
    _preferences.setString(key.name, value);
  }
}
