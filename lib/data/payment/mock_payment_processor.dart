import 'package:fintesthub_flutter/domain/payment/models/payment.dart';
import 'package:fintesthub_flutter/domain/payment/models/payment_result.dart';
import 'package:fintesthub_flutter/domain/payment/repositories/payment_processor.dart';

class MockPaymentProcessor extends PaymentProcessor{

  @override
  Future<PaymentResult> processPayment(Payment payment) {
    // Simulate a delay for processing
    return Future.delayed(Duration(seconds: 1), () {
      final random = DateTime.now().millisecondsSinceEpoch % 3;
      if (random == 0) {
        return SuccessResult("txn_${DateTime.now().millisecondsSinceEpoch}", message: "Payment successful");
      } else if (random == 1) {
        return FailureResult("ERR001", "Payment failed due to insufficient funds");
      } else {
        return CancelledResult(message: "Payment was cancelled by the user");
      }
    });
  }
}