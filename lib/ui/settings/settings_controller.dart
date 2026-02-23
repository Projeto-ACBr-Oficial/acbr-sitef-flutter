import 'package:flutter/material.dart';

import '../../core/config/local_settings_keys.dart';
import '../../domain/settings/models/settings.dart';

class SettingsController extends ChangeNotifier {
  final empresaController = TextEditingController();
  final enderecoController = TextEditingController();
  final operadorController = TextEditingController();
  final cnpjCpfController = TextEditingController();
  final cnpjAutomacaoController = TextEditingController();

  void loadSettings() {
    empresaController.text = Settings.getValue(
      SettingsKeys.empresaSitef,
      "00000000",
    );
    enderecoController.text = Settings.getValue(
      SettingsKeys.enderecoSitef,
      "127.0.0.1",
    );
    operadorController.text = Settings.getValue(SettingsKeys.operador, "0001");
    cnpjCpfController.text = Settings.getValue(
      SettingsKeys.cnpjCpf,
      "12345678912345",
    );
    cnpjAutomacaoController.text = Settings.getValue(
      SettingsKeys.cnpjAutomacao,
      "12345678912345",
    );
  }

  void updateField(String key, String value) {
    Settings.updateSetting(key, value);
  }

  @override
  void dispose() {
    empresaController.dispose();
    enderecoController.dispose();
    operadorController.dispose();
    cnpjCpfController.dispose();
    cnpjAutomacaoController.dispose();
    super.dispose();
  }
}
