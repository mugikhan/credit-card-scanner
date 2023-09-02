// A widget that displays the picture taken by the user.
import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_card_scanner/card_issuer.dart';
import 'package:flutter_card_scanner/card_utils.dart';
import 'package:flutter_card_scanner/credit_cards_view.dart';
import 'package:flutter_card_scanner/db/database.dart';
import 'package:flutter_card_scanner/db/models/credit_card.dart';
import 'package:flutter_card_scanner/extensions/string_x.dart';
import 'package:flutter_card_scanner/models/card_details.dart';
import 'package:flutter_card_scanner/models/exceptions.dart';
import 'package:flutter_card_scanner/services/custom_snackbar.dart';
import 'package:flutter_card_scanner/text_painter.dart';
import 'package:flutter_card_scanner/widgets/custom_dropdown.dart';
import 'package:flutter_card_scanner/widgets/custom_textfield.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final InputImageRotation imageRotation;

  const DisplayPictureScreen({
    super.key,
    required this.imagePath,
    required this.imageRotation,
  });

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  Size? _imageSize;
  CustomPaint? _customPaint;
  CardDetails? _cardDetails;
  CustomPainter? _customPainter;

  //Form
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardholderController = TextEditingController();
  final _cvcController = TextEditingController();

  String _expiryMonth = "01";
  int _expiryYear = 2023;

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

  List<int> get10YearsFromNow() {
    int minYear = 1999;
    List<int> years = [];

    int maxYear = 2028;
    for (int i = minYear; i <= maxYear; i++) {
      years.add(i);
    }
    return years;
  }

  @override
  void initState() {
    super.initState();
    _years = get10YearsFromNow();

    final inputImage = InputImage.fromFilePath(widget.imagePath);
    _getImageSize(File(widget.imagePath)).then((_) {
      _processImage(inputImage);
    });
  }

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: _imageSize != null
          ? SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.maxFinite,
                      color: Colors.black,
                      child: CustomPaint(
                        foregroundPainter: _customPainter,
                        child: AspectRatio(
                          aspectRatio: _imageSize!.aspectRatio,
                          child: Image.file(
                            File(widget.imagePath),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 8,
                      color: Colors.white,
                      child: Padding(
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a card number';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
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
                                      child: Row(
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            month,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "$year",
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FormTextField(
                                      label: "CVC",
                                      controller: _cvcController,
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
                                  SaveCardButton(
                                    formKey: _formKey,
                                    cardNumberController: _cardNumberController,
                                    cardHolderController: _cardholderController,
                                    cvcController: _cvcController,
                                    month: _expiryMonth,
                                    year: _expiryYear,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
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
      // // TODO: set _customPaint to draw boundingRect on top of image
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
      _cardDetails = CardDetails(
        cardNumber: creditCardNumber ?? "",
        cardHolderName: name ?? "",
        expiryDate: expiryDateString ?? "",
        cvc: cvc ?? "",
      );
      if (creditCardNumber != null) {
        _cardNumberController.text = creditCardNumber;
      }
      if (name != null) {
        _cardholderController.text = name;
      }
      if (expiryDateString != null && expiryDateString.length == 5) {
        String month = expiryDateString.monthFromExpiry;
        String year = expiryDateString.yearFromExpiry;
        String tempDate = "01/$month/$year";
        DateTime formattedDate = tempDate.fromDMYYtoDateTime;
        _expiryMonth = month;
        _expiryYear = formattedDate.year;
      }
      if (cvc != null) {
        _cvcController.text = cvc;
      }
      setState(() {});
      return;
    }
    return;
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
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController cvcController;
  final String month;
  final int year;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          String creditCardNumber = cardNumberController.text;
          String name = cardHolderController.text;
          String cvc = cvcController.text;
          CardIssuer cardIssuer = CardUtils.getCardIssuer(creditCardNumber);
          CreditCard creditCard = CreditCard()
            ..cardNumber = creditCardNumber
            ..cardHolderName = name
            ..expiryMonth = month
            ..expiryYear = year
            ..cvc = cvc
            ..cardType = cardIssuer;
          try {
            await DatabaseManager().saveCardDetails(creditCard);

            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CreditCardsView(),
              ),
            );
          } on ItemExistsException {
            CustomSnackbarService()
                .showErrorSnackbar("This card has already been saved.");
          } catch (error) {
            debugPrint("Unknown error $error");
          }
        }
      },
      child: const Text('Submit'),
    );
  }
}
