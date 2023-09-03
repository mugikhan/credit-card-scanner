import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_scanner/views/countries/select_banned_countries.dart';
import 'package:flutter_card_scanner/models/card_issuer.dart';
import 'package:flutter_card_scanner/db/database.dart';
import 'package:flutter_card_scanner/db/models/credit_card.dart';
import 'package:flutter_card_scanner/extensions/string_x.dart';
import 'package:flutter_card_scanner/theme/app_colors.dart';
import 'package:flutter_card_scanner/views/scan/text_recognizer_view.dart';

class CreditCardsView extends StatefulWidget {
  const CreditCardsView({super.key});

  @override
  State<CreditCardsView> createState() => _CreditCardsViewState();
}

class _CreditCardsViewState extends State<CreditCardsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View credit cards')),
      body: StreamBuilder<List<CreditCard>>(
          stream: DatabaseManager().watchAllCreditCards(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              List<CreditCard> creditCards = snapshot.data!;
              if (creditCards.isNotEmpty) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Text("Tap the cards to see the CVC/CVV code"),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: creditCards.length,
                            itemBuilder: (context, index) {
                              CreditCard creditCard = creditCards[index];
                              return CreditCardBuilder(
                                creditCard: creditCard,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(
                                  0, -1), // changes position of shadow
                            ),
                          ],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: _actionButtons(),
                      ),
                    ),
                  ],
                );
              } else {
                return _noCardsLayout();
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget _noCardsLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        const Text.rich(
          TextSpan(
              text: "You have no credit cards saved. Select the ",
              children: [
                TextSpan(
                    text: "Add new card",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                TextSpan(text: " button to add a credit card.")
              ]),
          style: TextStyle(
            fontSize: 24,
            height: 1.2,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        _actionButtons(),
      ],
    );
  }

  Widget _actionButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TextRecognizerView(),
                ),
              );
            },
            style: ButtonStyle(
              padding: const MaterialStatePropertyAll(EdgeInsets.all(12.0)),
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
            label: const Text("Add new card"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SelectBannedCountriesView(),
                  ),
                );
              },
              style: ButtonStyle(
                padding: const MaterialStatePropertyAll(EdgeInsets.all(12.0)),
                maximumSize: const MaterialStatePropertyAll(
                  Size(200, 50),
                ),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              icon: const Icon(Icons.add),
              label: const Text("Banned countries"),
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardBuilder extends StatefulWidget {
  const CreditCardBuilder({
    Key? key,
    required this.creditCard,
  }) : super(key: key);

  final CreditCard creditCard;

  @override
  State<CreditCardBuilder> createState() => _CreditCardBuilderState();
}

class _CreditCardBuilderState extends State<CreditCardBuilder> {
  bool _displayFront = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          _displayFront = !_displayFront;
        });
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        transitionBuilder: _transitionBuilder,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut.flipped,
        //Reverse display order so that the widget to replace is at the top
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: _displayFront ? _buildFront(width) : _buildRear(width),
      ),
    );
  }

  //Flip animation
  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_displayFront) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFront(double width) {
    return Card(
      key: const ValueKey(true),
      elevation: 4.0,
      color: AppColor.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: width,
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogos(widget.creditCard.cardType),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                widget.creditCard.cardNumber ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: widget.creditCard.cardHolderName ?? "",
                ),
                _buildDetailsBlock(
                  label: 'VALID THRU',
                  value:
                      "${widget.creditCard.expiryMonth ?? ""}/${widget.creditCard.expiryYear?.toString().twoDigitYear ?? ""}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRear(double width) {
    return Card(
      key: const ValueKey(false),
      elevation: 4.0,
      color: AppColor.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: SizedBox(
        width: width,
        height: 200,
        // padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: width,
              margin: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const Text(
                    "Security\ncode",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: 1.2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.creditCard.cvc ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogos(CardIssuer? cardIssuer) {
    String? cardTypePath;
    if (cardIssuer != null) {
      switch (cardIssuer) {
        case CardIssuer.visa:
          cardTypePath = "assets/visa.png";
          break;
        case CardIssuer.mastercard:
          cardTypePath = "assets/master_card.png";
          break;
        case CardIssuer.unknown:
          break;
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Icon(
          Icons.contactless,
          color: Colors.white,
          size: 36,
        ),
        cardTypePath != null
            ? Image.asset(
                cardTypePath,
                height: 50,
                width: 50,
              )
            : const SizedBox(
                width: 50,
                height: 50,
              ),
      ],
    );
  }

  Widget _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
