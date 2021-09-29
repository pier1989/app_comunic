import 'package:app_comunic/app/domain/repositories/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const darkModeKey = 'dark-mode';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final SharedPreferences _preferences;

  PreferencesRepositoryImpl(this._preferences);

  @override
  bool get IsdarkModes => _preferences.getBool('dark-mode') ?? false;

  @override
  Future<void> darkMode(bool enable) {
    return _preferences.setBool(darkModeKey, enable);
  }
}
