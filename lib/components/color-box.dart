import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final bool hideBottomBar;
  final double width;
  final double height;
  final String text;

  ColorBox({
    this.hideBottomBar = true,
    this.width = 250.0,
    this.height = 100.0,
    this.text = "T-Shirt",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 10,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Unbounded',
                  fontSize: 18,
                ),
              ),
            ),
            Positioned(
              right: 10,
              // top: height / 3,
              child: Container(
                width: width/5,  // Circle diameter
                height: width/5,  // Circle diameter
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
