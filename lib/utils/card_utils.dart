import 'package:flutter_card_scanner/models/card_issuer.dart';

class CardUtils {
  //Mastercard numbers start with 51-59 followed by 14 digits
  static final mastercard = RegExp(
      '^(5[1-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))\$');
  //Visa numbers start with 4 followed by 12 digits
  static final visa = RegExp('^4[0-9]{12}(?:[0-9]{3})?\$');

  static final unknown = RegExp('.*');

  static CardIssuer getCardIssuer(String cardNumber) {
    cardNumber = cardNumber.replaceAll(' ', '');
    var issuerMap = <RegExp, CardIssuer>{
      mastercard: CardIssuer.mastercard,
      visa: CardIssuer.visa,
      unknown: CardIssuer.unknown,
    };

    var matchingRegex = <RegExp>[
      mastercard,
      visa,
      unknown,
    ].firstWhere((element) => element.hasMatch(cardNumber));

    return issuerMap[matchingRegex]!;
  }
}
