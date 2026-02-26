
import '../../../core/config/local_settings_keys.dart';
import '../../../domain/settings/models/settings.dart';

class MsitefAdminMapper {
  static Map<String, dynamic> toMap() {
    return {
      // -- Dados de configuração
      'empresaSitef': Settings.getValue(SettingsKeys.empresaSitef, "00000000"),
      'enderecoSitef': Settings.getValue(SettingsKeys.enderecoSitef, "127.0.0.1"),
      'operador': Settings.getValue(SettingsKeys.operador, "0001"),
      'cnpjCpf': Settings.getValue(SettingsKeys.cnpjCpf, "12345678912345"),
      'cnpjAutomacao': Settings.getValue(SettingsKeys.cnpjAutomacao, "12345678912345"),
    };
  }
}