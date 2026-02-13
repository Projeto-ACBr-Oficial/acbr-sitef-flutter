/// Enumeração que define os tipos de pagamento suportados.
enum PaymentType {
  debit("Débito"),
  credit("Crédito"),
  pix("Pix"),
  voucher("Voucher"),
  instantPayment("Pagamento Instantâneo");

  final String text;

  const PaymentType(this.text);
}