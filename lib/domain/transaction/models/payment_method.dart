/// Representa um método de pagamento disponível para uma transação.
///
/// * [id] O id do método de pagamento.
/// * [name] O nome do método de pagamento.
/// * [maxInstallments] A quantidade máxima de parcelas permitidas.
/// * [requiresInstallments] Indica se o método de pagamento permite parcelamento.
class PaymentMethod {
  final String id;
  final String name;
  final int maxInstallments;
  final bool requiresInstallments;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.maxInstallments,
    required this.requiresInstallments,
  });
}
