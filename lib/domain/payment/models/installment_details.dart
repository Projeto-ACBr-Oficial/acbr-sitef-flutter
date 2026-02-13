import 'package:fintesthub_flutter/domain/payment/models/enums/installment_type.dart';

/// Representa os detalhes do parcelamento de um pagamento.
///
/// * [installments] Quantidade de parcelas
/// * [installmentType] Tipo de parcelamento
///
class InstallmentDetails {
  final int installments;
  final InstallmentType installmentType;

  InstallmentDetails({
    required this.installments,
    required this.installmentType,
  });
}
