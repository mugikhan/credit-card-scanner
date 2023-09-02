enum CardIssuer {
  visa("Visa"),
  mastercard("Mastercard"),
  unknown("Unknown");

  final String cardIssuerName;

  const CardIssuer(this.cardIssuerName);
}
