import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_scanner/camera_view.dart';
import 'package:flutter_card_scanner/models/card_details.dart';
import 'package:flutter_card_scanner/widgets/text_painter.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:collection/collection.dart';

class TextRecognizerView extends StatefulWidget {
  const TextRecognizerView({super.key});

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  var _script = TextRecognitionScript.latin;
  var _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;

  CardDetails? cardDetails;

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text detector'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(children: [
        CameraView(
          customPaint: _customPaint,
          onImage: _processImage,
          // onCameraFeedReady: widget.onCameraFeedReady,
          // onDetectorViewModeChanged: _onDetectorViewModeChanged,
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
        ),
        Positioned(
            top: 30,
            left: 100,
            right: 100,
            child: Row(
              children: [
                const Spacer(),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _buildDropdown(),
                    )),
                const Spacer(),
              ],
            )),
      ]),
    );
  }

  Widget _buildDropdown() => DropdownButton<TextRecognitionScript>(
        value: _script,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (TextRecognitionScript? script) {
          if (script != null) {
            setState(() {
              _script = script;
              _textRecognizer.close();
              _textRecognizer = TextRecognizer(script: _script);
            });
          }
        },
        items: TextRecognitionScript.values
            .map<DropdownMenuItem<TextRecognitionScript>>((script) {
          return DropdownMenuItem<TextRecognitionScript>(
            value: script,
            child: Text(script.name),
          );
        }).toList(),
      );

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    parseResults(recognizedText.blocks);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = TextRecognizerPainter(
        recognizedText,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
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
      setState(() {
        cardDetails = CardDetails(
          cardNumber: creditCardNumber ?? "",
          cardHolderName: name ?? "",
          expiryDate: expiryDateString ?? "",
          cvc: cvc ?? "",
        );
      });
      print(cardDetails.toString());
      return;
    }
    return;
  }
}
