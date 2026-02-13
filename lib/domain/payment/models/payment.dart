import 'package:fintesthub_flutter/domain/payment/models/enums/payment_type.dart';

import 'installment_details.dart';

/// Representa um pagamento.
///
///  * [id] O ID do pagamento.
///  * [amount] O valor do pagamento.
///  * [type] O tipo de pagamento (crédito, débito, pix, etc.).
///  * [installmentDetails] Detalhes do parcelamento.
///
class Payment {
  final int id;
  final double amount;
  final PaymentType type;
  final InstallmentDetails? installmentDetails;

  const Payment({
    required this.id,
    required this.amount,
    required this.type,
    required this.installmentDetails,
  });
}
