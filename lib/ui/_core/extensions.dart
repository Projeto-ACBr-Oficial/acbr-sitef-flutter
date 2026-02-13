import 'package:intl/intl.dart';

extension IntCurrencyExtension on int {
  /// Converte centavos (int) para o valor real (double)
  double toAmount() => this / 100.0;

  /// Converte centavos (int) para String formatada em R$ X,XX
  String toCurrency() {
    return NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
    ).format(toAmount());
  }
}

extension DoubleCurrencyExtension on double {
  String toCurrency() {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(this);
  }
}
