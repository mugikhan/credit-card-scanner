import 'package:flutter/material.dart';

class CustomPhotoButton extends StatelessWidget {
  const CustomPhotoButton(
      {Key? key,
      required this.innerColor,
      required this.innerShape,
      required this.onTap,
      this.height = 40.0,
      this.width = 40.0})
      : super(key: key);

  final Color innerColor;
  final BoxShape innerShape;
  final GestureTapCallback onTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: <Widget>[
          Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 5.0,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn,
                width: width,
                height: height,
                decoration: BoxDecoration(color: innerColor, shape: innerShape),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
