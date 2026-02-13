import 'package:fintesthub_flutter/domain/payment/models/payment.dart';
import 'package:fintesthub_flutter/domain/payment/models/payment_result.dart';

abstract class PaymentProcessor {
  Future<PaymentResult> processPayment(Payment payment);
}
