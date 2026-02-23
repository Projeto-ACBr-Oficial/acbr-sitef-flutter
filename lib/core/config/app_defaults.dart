import 'package:fintesthub_flutter/core/config/local_settings_keys.dart';

import '../../domain/settings/models/setting.dart';

final List<Setting> sitefDefaultSettings = [
  Setting(key: SettingsKeys.empresaSitef, value: "00000000"),
  Setting(key: SettingsKeys.enderecoSitef, value: "127.0.0.1"),
  Setting(key: SettingsKeys.operador, value: "0001"),
  Setting(key: SettingsKeys.cnpjCpf, value: "12345678912345"),
  Setting(key: SettingsKeys.cnpjAutomacao, value: "12345678912345"),
];
