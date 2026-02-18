import '../payment.dart';

extension PaymentToMapExtension on Payment {
  /// Converte o objeto de domínio para o formato que o Android (Kotlin) espera
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type.name,
      'installments': installmentDetails?.installments,
      'installmentType': installmentDetails?.installmentType.name ?? 'none',
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };
  }
}