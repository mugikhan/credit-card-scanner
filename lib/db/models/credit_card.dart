import 'package:flutter_card_scanner/models/card_issuer.dart';
import 'package:isar/isar.dart';

part 'credit_card.g.dart';

@collection
class CreditCard {
  Id id = Isar.autoIncrement;

  @Index(unique: true) //Ensure only one card number is stored
  String? cardNumber;
  String? cardHolderName;

  String? expiryMonth;
  int? expiryYear;

  String? cvv;

  String? issuingCountry;

  @Enumerated(EnumType.value, 'cardIssuerName')
  CardIssuer cardType = CardIssuer.unknown;
}
