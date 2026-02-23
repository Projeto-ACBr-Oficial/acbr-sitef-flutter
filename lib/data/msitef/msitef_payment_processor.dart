import 'package:fintesthub_flutter/data/msitef/msitef_payment_mapper.dart';
import 'package:fintesthub_flutter/domain/payment/models/payment.dart';
import 'package:fintesthub_flutter/domain/payment/models/payment_result.dart';
import 'package:fintesthub_flutter/domain/payment/repositories/payment_processor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MSitefPaymentProcessor extends PaymentProcessor {
  static const _channel = MethodChannel('com.mjtech.fintesthub.flutter/msitef');

  @override
  Future<PaymentResult> processPayment(Payment payment) async {
    try {
      final map = MsitefPaymentMapper.toMsitefMap(payment);

      final result = await _channel.invokeMethod('pay', map);

      return _parseResult(result);
    } on PlatformException catch (e) {
      return FailureResult(
        e.code,
        e.message ?? "Erro de comunicação com o sistema",
      );
    } catch (e) {
      return FailureResult("UNKNOWN", e.toString());
    }
  }

  PaymentResult _parseResult(dynamic result) {
    debugPrint("Native Result: $result");

    if (result == null) {
      return CancelledResult(message: "Sem resposta do Android");
    }

    return switch (result['status']) {
      'SUCCESS' => SuccessResult(
        result['id'].toString(),
        message: result['message'],
      ),
      'FAILURE' => FailureResult(
        result['errorCode'] ?? '1',
        result['errorMessage'] ?? 'Erro',
      ),
      'CANCELLED' => CancelledResult(message: result['message']),
      _ => CancelledResult(message: "Status desconhecido: ${result['status']}"),
    };
  }
}
