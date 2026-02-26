import 'package:fintesthub_flutter/domain/payment/models/payment.dart';

import '../../../core/config/local_settings_keys.dart';
import '../../../domain/settings/models/settings.dart';

class MsitefPaymentMapper {
  static Map<String, dynamic> toMap(Payment payment) {
    return {
      'id':payment.id,
      'amount': payment.amount,
      'type': payment.type.name,
      'installments': payment.installmentDetails?.installments,
      'installmentType': payment.installmentDetails?.installmentType.name ?? 'none',

      // -- Dados de configuração
      'empresaSitef': Settings.getValue(SettingsKeys.empresaSitef, "00000000"),
      'enderecoSitef': Settings.getValue(SettingsKeys.enderecoSitef, "127.0.0.1"),
      'operador': Settings.getValue(SettingsKeys.operador, "0001"),
      'cnpjCpf': Settings.getValue(SettingsKeys.cnpjCpf, "12345678912345"),
      'cnpjAutomacao': Settings.getValue(SettingsKeys.cnpjAutomacao, "12345678912345"),
    };
  }
}