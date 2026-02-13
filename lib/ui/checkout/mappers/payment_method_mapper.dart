import 'package:fintesthub_flutter/domain/transaction/models/payment_method.dart';
import 'package:fintesthub_flutter/ui/checkout/models/payment_method_ui.dart';
import 'package:flutter/material.dart';

extension PaymentMethodMapper on PaymentMethod {
  PaymentMethodUi toUi() {
    final (icon, color, description) = _getUiAssetsForPaymentType(id);

    return PaymentMethodUi(
      id: id,
      name: name,
      description: description,
      color: color,
      icon: icon,
    );
  }

  (IconData, Color, String) _getUiAssetsForPaymentType(String methodId) {
    return switch (methodId.toUpperCase()) {
      "DEBIT" => (Icons.credit_card, Colors.red, "Cartão de Débito"),
      "CREDIT" => (Icons.credit_card, Colors.green, "Cartão de Crédito"),
      "PIX" => (
        Icons.account_balance,
        Colors.purple,
        "PIX e carteiras digitais",
      ),
      "VOUCHER" => (
        Icons.credit_card,
        Colors.blue,
        "Vale alimentação ou refeição",
      ),
      _ => (Icons.help_outline, Colors.grey, "Método desconhecido"),
    };
  }
}
