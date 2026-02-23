import 'package:fintesthub_flutter/domain/settings/repositories/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/common/result.dart';
import '../../domain/settings/models/setting.dart';

class LocalSettingsRepository implements SettingsRepository {
  final SharedPreferences _prefs;

  LocalSettingsRepository(this._prefs);

  @override
  Future<Result<Setting>> getSetting(Setting setting) async {
    try {
      final key = setting.key;
      final defaultValue = setting.value;
      dynamic value;

      if (defaultValue is String) {
        value = _prefs.getString(key) ?? defaultValue;
      } else if (defaultValue is bool) {
        value = _prefs.getBool(key) ?? defaultValue;
      } else if (defaultValue is int) {
        value = _prefs.getInt(key) ?? defaultValue;
      } else if (defaultValue is double) {
        value = _prefs.getDouble(key) ?? defaultValue;
      } else {
        return Result.failure("Tipo não suportado");
      }

      return Result.success(Setting(key: key, value: value));
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> saveSetting(Setting setting) async {
    try {
      final key = setting.key;
      final value = setting.value;
      bool success = false;

      if (value is String) {
        success = await _prefs.setString(key, value);
      } else if (value is bool) {
        success = await _prefs.setBool(key, value);
      } else if (value is int) {
        success = await _prefs.setInt(key, value);
      } else if (value is double) {
        success = await _prefs.setDouble(key, value);
      }

      return success ? Result.success(null) : Result.failure("Falha ao salvar");
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
