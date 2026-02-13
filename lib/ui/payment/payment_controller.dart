import 'package:fintesthub_flutter/ui/_core/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class PaymentController extends ChangeNotifier {
  String _rawDigits = "";
  String? errorMessage;

  int get valueInCents => int.tryParse(_rawDigits) ?? 0;

  String get formattedValue {
    if (_rawDigits.isEmpty) return "R\$ 0,00";
    double value = valueInCents.toAmount();
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
  }

  void appendNumber(int n) {
    if (_rawDigits.isEmpty && n == 0) return;
    if (_rawDigits.length < 9) {
      _rawDigits += n.toString();
      notifyListeners();
    }
  }

  void deleteLastDigit() {
    if (_rawDigits.isNotEmpty) {
      _rawDigits = _rawDigits.substring(0, _rawDigits.length - 1);
      notifyListeners();
    }
  }

  void clearValue() {
    _rawDigits = "";
    notifyListeners();
  }

  bool onPaymentAction() {
    if (valueInCents <= 0) {
      errorMessage = "Insira um valor maior que zero";
      notifyListeners();
      return false;
    }
    return true;
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
