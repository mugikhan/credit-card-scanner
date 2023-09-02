import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_card_scanner/countries/select_banned_countries.dart';
import 'package:flutter_card_scanner/models/card_issuer.dart';
import 'package:flutter_card_scanner/db/database.dart';
import 'package:flutter_card_scanner/db/models/credit_card.dart';
import 'package:flutter_card_scanner/extensions/string_x.dart';
import 'package:flutter_card_scanner/theme/app_colors.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SelectBannedCountriesView(),
            ),
          );
        },
        label: const Text('Countries'),
        icon: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<CreditCard>>(
          stream: DatabaseManager().watchAllCreditCards(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData) {
              List<CreditCard> creditCards = snapshot.data!;
              return ListView.builder(
                itemCount: creditCards.length,
                itemBuilder: (context, index) {
                  CreditCard creditCard = creditCards[index];
                  return CreditCardBuilder(
                    creditCard: creditCard,
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

class CreditCardBuilder extends StatefulWidget {
  const CreditCardBuilder({
    Key? key,
    required this.creditCard,
  });

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
                widget.creditCard.cardNumber!,
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
                  value: widget.creditCard.cardHolderName!,
                ),
                _buildDetailsBlock(
                  label: 'VALID THRU',
                  value:
                      "${widget.creditCard.expiryMonth!}/${widget.creditCard.expiryYear!.toString().twoDigitYear}",
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
                      widget.creditCard.cvc!,
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
          cardTypePath = "assets/mastercard.png";
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
