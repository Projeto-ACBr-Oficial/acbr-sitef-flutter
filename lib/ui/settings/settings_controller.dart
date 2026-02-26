import 'package:fintesthub_flutter/domain/settings/repositories/tef_admin_action.dart';
import 'package:flutter/material.dart';

import '../../core/config/local_settings_keys.dart';
import '../../domain/common/result.dart';
import '../../domain/settings/models/settings.dart';

class SettingsController extends ChangeNotifier {
  final TefAdminAction _adminAction;

  final empresaController = TextEditingController();
  final enderecoController = TextEditingController();
  final operadorController = TextEditingController();
  final cnpjCpfController = TextEditingController();
  final cnpjAutomacaoController = TextEditingController();

  SettingsController({required TefAdminAction adminAction})
    : _adminAction = adminAction;

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

  Future<void> openAdminMenu({
    required Function(String) onReceiptReceived,
    required Function(String) onError,
  }) async {
    final result = await _adminAction.openAdminMenu();

    switch (result) {
      case Success(data: var response):
        if (response.receipt.isNotEmpty) {
          onReceiptReceived(response.receipt);
        }
      case Failure(error: var msg):
        onError(msg);
    }
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
