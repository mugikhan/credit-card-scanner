import 'package:flutter_card_scanner/utils/card_utils.dart';

class CardDetails {
  String _cardNumber = "";
  String _cardHolderName = "";
  String _expiryDate = "";
  String _cardIssuer = "";

  String _cvc = "";

  CardDetails({
    required String cardNumber,
    required String cardHolderName,
    required String expiryDate,
    String cvc = "",
  }) {
    _cardNumber = cardNumber;
    _cardHolderName = cardHolderName;
    _expiryDate = expiryDate;
    // _cardIssuer = CardUtils().getCardIssuer(_cardNumber).cardIssuerName;
    _cvc = cvc;
  }

  @override
  String toString() {
    var string = '';
    string += _cardNumber.isEmpty ? "" : 'Card Number = $cardNumber\n';
    string += _expiryDate.isEmpty ? "" : 'Expiry Date = $expiryDate\n';
    string += _cardIssuer.isEmpty ? "" : 'Card Issuer = $cardIssuer\n';
    string +=
        _cardHolderName.isEmpty ? "" : 'Card Holder Name = $cardHolderName\n';
    string += _cvc.isEmpty ? "" : 'CVC = $cvc\n';
    return string;
  }

  String get cardNumber => _cardNumber;

  String get cardIssuer => _cardIssuer;

  String get cardHolderName => _cardHolderName;

  String get expiryDate => _expiryDate;

  String get cvc => _cvc;
}
