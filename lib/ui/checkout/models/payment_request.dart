import '../../../domain/payment/models/enums/payment_type.dart';

class PaymentRequest {
  final double amount;
  final PaymentType type;
  final int installments;

  PaymentRequest({
    required this.amount,
    required this.type,
    required this.installments,
  });
}
