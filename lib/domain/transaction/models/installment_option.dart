/// Representa uma opção de parcelamento para uma transação.
///
/// * [count] Número da parcela.
/// * [totalAmount] Valor total da parcela.
/// * [interestRate] Taxa de juros aplicada à parcela.
/// * [monthlyAmount] Valor da parcela mensal.
///
class InstallmentOption {
  final int count;
  final double totalAmount;
  final double interestRate;
  final double monthlyAmount;

  const InstallmentOption({
    required this.count,
    required this.totalAmount,
    required this.interestRate,
    required this.monthlyAmount,
  });
}
