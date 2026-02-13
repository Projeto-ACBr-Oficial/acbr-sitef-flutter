/// Enumeração que define os tipos de parcelamentos suportados.
///
/// * [none] Sem parcelamento, pagamento à vista.
/// * [merchant] Parcelamento oferecido pelo comerciante (sem juros).
/// * [issuer] Parcelamento oferecido pela instituição financeira (pode ter juros).
///
enum InstallmentType {
  none("NONE"),
  merchant("MERCHANT"),
  issuer("ISSUER");

  final String value;

  const InstallmentType(this.value);
}