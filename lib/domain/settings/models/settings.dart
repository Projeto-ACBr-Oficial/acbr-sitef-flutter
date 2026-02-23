import 'package:fintesthub_flutter/domain/settings/models/setting.dart';

import '../../common/result.dart';
import '../repositories/settings_repository.dart';

class Settings {
  static final Map<String, dynamic> _settingsMap = {};

  static late SettingsRepository _repository;

  static Future<void> init({
    required SettingsRepository repository,
    required List<Setting> defaultSettings,
  }) async {
    _repository = repository;

    for (var defaultSetting in defaultSettings) {
      final result = await _repository.getSetting(defaultSetting);

      if (result is Success<Setting>) {
        _settingsMap[defaultSetting.key] = result.data.value;
      } else {
        _settingsMap[defaultSetting.key] = defaultSetting.value;
        await _repository.saveSetting(defaultSetting);
      }
    }
  }

  static T getValue<T>(String key, T defaultValue) {
    final value = _settingsMap[key];

    if (value != null && value is T) {
      return value;
    }
    return defaultValue;
  }

  static Future<Result<void>> updateSetting(String key, dynamic value) async {
    _settingsMap[key] = value;
    return await _repository.saveSetting(Setting(key: key, value: value));
  }
}
