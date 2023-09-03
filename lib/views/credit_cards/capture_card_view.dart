// A widget that displays the picture taken by the user.
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_card_scanner/constants/constants.dart';
import 'package:flutter_card_scanner/db/models/banned_countries.dart';
import 'package:flutter_card_scanner/models/card_issuer.dart';
import 'package:flutter_card_scanner/utils/card_utils.dart';
import 'package:flutter_card_scanner/db/database.dart';
import 'package:flutter_card_scanner/db/models/credit_card.dart';
import 'package:flutter_card_scanner/extensions/string_x.dart';
import 'package:flutter_card_scanner/models/exceptions.dart';
import 'package:flutter_card_scanner/services/custom_snackbar.dart';
import 'package:flutter_card_scanner/views/credit_cards/credit_cards_view.dart';
import 'package:flutter_card_scanner/views/scan/text_recognizer_view.dart';
import 'package:flutter_card_scanner/widgets/text_painter.dart';
import 'package:flutter_card_scanner/widgets/custom_dropdown.dart';
import 'package:flutter_card_scanner/widgets/custom_textfield.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CaptureCardView extends StatefulWidget {
  final String imagePath;
  final InputImageRotation imageRotation;

  const CaptureCardView({
    super.key,
    required this.imagePath,
    required this.imageRotation,
  });

  @override
  State<CaptureCardView> createState() => _CaptureCardViewState();
}

class _CaptureCardViewState extends State<CaptureCardView> {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  Size? _imageSize;
  CustomPaint? _customPaint;
  CustomPainter? _customPainter;

  //Form
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardholderController = TextEditingController();
  final _cvcController = TextEditingController();

  String _expiryMonth = "01";
  int _expiryYear = 2023;
  CreditCard _creditCard = CreditCard();

  String _issuingCountry = "";

  CardIssuer _cardIssuer = CardIssuer.unknown;

  List<String> _months = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  List<int> _years = [];

  List<int> _getYearsFrom99() {
    int minYear = 1999;
    List<int> years = [];

    int maxYear = 2028;
    for (int i = minYear; i <= maxYear; i++) {
      years.add(i);
    }
    return years;
  }

  void _setIssuingCountry(String country) {
    setState(() {
      _issuingCountry = country;
    });
  }

  @override
  void initState() {
    super.initState();
    _years = _getYearsFrom99();
    //Update with default values
    _updateExpiryDate(_expiryMonth, _expiryYear);

    _cardNumberController.addListener(_updateCreditCardNumber);
    _cardholderController.addListener(_updateCardHolder);
    _cvcController.addListener(_updateCVC);

    final inputImage = InputImage.fromFilePath(widget.imagePath);
    _getImageSize(File(widget.imagePath)).then((_) {
      _processImage(inputImage);
    });
  }

  @override
  void dispose() {
    _textRecognizer.close();
    _cardNumberController.dispose();
    _cardholderController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  void _updateCreditCardNumber() {
    if (_cardNumberController.text.isNotEmpty) {
      _creditCard.cardNumber = _cardNumberController.text;
      setState(() {
        CardIssuer cardType =
            CardUtils.getCardIssuer(_cardNumberController.text);
        _updateCardIssuer(cardType);
      });
    }
  }

  void _updateCardHolder() {
    if (_cardholderController.text.isNotEmpty) {
      _creditCard.cardHolderName = _cardholderController.text;
    }
  }

  void _updateCardIssuer(CardIssuer cardIssuer) {
    _creditCard.cardType = cardIssuer;
    setState(() {
      _cardIssuer = cardIssuer;
    });
  }

  void _updateExpiryDate(String month, int year) {
    _creditCard.expiryMonth = month;
    _creditCard.expiryYear = year;
  }

  void _updateCVC() {
    if (_cvcController.text.isNotEmpty) {
      _creditCard.cvc = _cvcController.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        body: _imageSize != null
            ? SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CreditCardBuilder(
                      creditCard: _creditCard,
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Text("Tap the card to see the CVC/CVV code"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const TextRecognizerView(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      style: ButtonStyle(
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.all(12.0)),
                        maximumSize: const MaterialStatePropertyAll(
                          Size(200, 50),
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Scan again"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormTextField(
                                    label: "Card number",
                                    controller: _cardNumberController,
                                    maxLength: 19,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a card number';
                                      } else if (!RegExp(
                                              r'^((4\d{3})|(5[1-5]\d{2})|(6011)|(34\d{1})|(37\d{1}))-?\s?\d{4}-?\s?\d{4}-?\s?\d{4}|3[4,7][\d\s-]{15}$')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid card number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                _cardTypeDropdown(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormTextField(
                                    label: "Cardholder name",
                                    controller: _cardholderController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a card holder';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: _buildExpiryDateDropdowns(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FormTextField(
                                    label: "CVC",
                                    controller: _cvcController,
                                    maxLength: 3,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a cvc number';
                                      } else if (value.length != 3) {
                                        return 'Please enter a 3 digit cvc number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CountryDropdown(
                                    setIssuingCountry: _setIssuingCountry,
                                  ),
                                ),
                                SaveCardButton(
                                  formKey: _formKey,
                                  cardNumberController: _cardNumberController,
                                  cardHolderController: _cardholderController,
                                  cvcController: _cvcController,
                                  month: _expiryMonth,
                                  year: _expiryYear,
                                  issuingCountry: _issuingCountry,
                                  cardIssuer: _cardIssuer,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  Widget _cardTypeDropdown() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormDropdownField<CardIssuer>(
            label: "Card type",
            value: _cardIssuer,
            items: CardIssuer.values.map((issuer) {
              return DropdownMenuItem(
                value: issuer,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        issuer.cardIssuerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (CardIssuer? value) {
              _updateCardIssuer(value!);
            }),
      ),
    );
  }

  Widget _buildExpiryDateDropdowns() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: FormDropdownField<String>(
              label: "Month",
              value: _expiryMonth,
              items: _months.map((month) {
                return DropdownMenuItem(
                  value: month,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          month,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _expiryMonth = value!;
                });
              }),
        ),
        Flexible(
          child: FormDropdownField<int>(
              label: "Year",
              value: _expiryYear,
              items: _years.map((year) {
                return DropdownMenuItem(
                  value: year,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "$year",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (int? value) {
                setState(() {
                  _expiryYear = value!;
                });
              }),
        ),
      ],
    );
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();
    final Image image = Image.file(imageFile);

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;

    setState(() {
      _imageSize = imageSize;
    });
  }

  Future<void> _processImage(InputImage inputImage) async {
    final recognizedText = await _textRecognizer.processImage(inputImage);
    parseResults(recognizedText.blocks);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(
        recognizedText,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        CameraLensDirection.back,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      print('Recognized text:\n\n${recognizedText.text}');
      _customPainter = TextRecognizerPainter(
        recognizedText,
        _imageSize!,
        widget.imageRotation,
        CameraLensDirection.back,
      );
      // _customPaint = null;
    }
    // _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  void parseResults(List<TextBlock> blocks) {
    RegExp regex = RegExp(
      r'\s*(\bEzzyBooks\b|\bMONTH/YEAR\b|\bBank\sName\b|\bVISA\b|\bbiometric\b|\bVALID\b|\bTHRU\b|\bCVC\b|\bmastercard\b)(?:.*-*\s*)',
      caseSensitive: false,
    );
    if (blocks.isNotEmpty) {
      // Credit Card Number
      String? creditCardNumber = blocks
          .firstWhereOrNull((block) =>
              block.text.length > 14 &&
              ["1", "4", "5", "3", "6"].contains(block.text[0]))
          ?.text;
      // Expiry Date
      String? expiryDateString = blocks
          .firstWhereOrNull((block) =>
              block.text.length <= 6 &&
              block.text.contains("/") &&
              (!regex.hasMatch(block.text)))
          ?.text;
      //  var expiryDate = expiryDateString?.filter({ $0.isNumber || $0 == "/" })

      String? cvcString = blocks
          .firstWhereOrNull(
              (block) => block.text.length <= 7 && block.text.contains("CVC"))
          ?.text;
      String? cvc = cvcString?.split(" ")[1];
      // Name
      var newIgnoreString = "$creditCardNumber $expiryDateString $cvcString";
      String? name = blocks
          .lastWhereOrNull((block) =>
              !regex.hasMatch(block.text) &&
              !newIgnoreString.contains(block.text))
          // !withoutNulls.contains(block.text) &&
          // !lowerCased.contains(block.text))
          ?.text;
      if (creditCardNumber != null) {
        _cardNumberController.text = creditCardNumber;
        _creditCard.cardNumber = creditCardNumber;
        //Get card type from card num
        CardIssuer cardIssuer = CardUtils.getCardIssuer(creditCardNumber);
        _cardIssuer = cardIssuer;
      }
      if (name != null) {
        _cardholderController.text = name;
        _creditCard.cardHolderName = name;
      }
      if (expiryDateString != null && expiryDateString.length == 5) {
        String month = expiryDateString.monthFromExpiry;
        String year = expiryDateString.yearFromExpiry;
        if (int.tryParse(month) != null) {
          String tempDate = "01/$month/$year";
          DateTime formattedDate = tempDate.fromDMYYtoDateTime;
          _expiryMonth = month;
          _expiryYear = formattedDate.year;
          _creditCard.expiryMonth = month;
          _creditCard.expiryYear = formattedDate.year;
        }
      }
      if (cvc != null && cvc.length == 3) {
        _cvcController.text = cvc;
        _creditCard.cvc = cvc;
      }
      setState(() {});
      return;
    }
    return;
  }
}

class CountryDropdown extends StatefulWidget {
  const CountryDropdown({
    super.key,
    required this.setIssuingCountry,
  });

  final Function(String) setIssuingCountry;

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  String? _selectedCountry;

  List<String> _allCountries = [];

  @override
  void initState() {
    super.initState();

    _allCountries.addAll(countries);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<BannedCountry>>(
        stream: DatabaseManager().watchBannedCountries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            List<BannedCountry> bannedCountries = snapshot.data!;
            _allCountries.removeWhere(
              (country) => bannedCountries
                  .any((bannedCountry) => country == bannedCountry.country),
            );
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormDropdownField<String>(
                  label: "Issuing country",
                  items: _allCountries.map((country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      widget.setIssuingCountry(value);
                      setState(() {
                        _selectedCountry = value;
                      });
                    }
                  },
                  value: _selectedCountry,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an issuing country';
                    }
                    return null;
                  },
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class SaveCardButton extends StatelessWidget {
  const SaveCardButton({
    Key? key,
    required this.formKey,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.cvcController,
    required this.month,
    required this.year,
    required this.issuingCountry,
    required this.cardIssuer,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController cvcController;
  final String month;
  final int year;
  final String issuingCountry;
  final CardIssuer cardIssuer;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          String creditCardNumber = cardNumberController.text;
          String name = cardHolderController.text;
          String cvc = cvcController.text;
          CreditCard creditCard = CreditCard()
            ..cardNumber = creditCardNumber
            ..cardHolderName = name
            ..expiryMonth = month
            ..expiryYear = year
            ..cvc = cvc
            ..issuingCountry = issuingCountry
            ..cardType = cardIssuer;
          try {
            await DatabaseManager().saveCardDetails(creditCard);

            if (context.mounted) {
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const CreditCardsView(),
                ),
              );
            }
          } on ItemExistsException {
            CustomSnackbarService()
                .showErrorSnackbar("This card has already been saved.");
          } catch (error) {
            debugPrint("Unknown error $error");
          }
        }
      },
      child: const Text('Save card'),
    );
  }
}
