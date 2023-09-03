import 'package:flutter/material.dart';
import 'package:flutter_card_scanner/theme/app_colors.dart';

class CircleNumButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final double size;
  final String text;
  final bool isSelected;

  const CircleNumButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.size = 40.0,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(2.0),
        decoration: const BoxDecoration(
          color: AppColor.zoomFill,
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.amber : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteCircleNumButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final double size;
  final int number;

  const WhiteCircleNumButton({
    Key? key,
    required this.onTap,
    this.number = 0,
    this.size = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            // shape: BoxShape.circle,
            border: Border.all(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(size / 2),
          ),
          child: Text(
            "$number",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
