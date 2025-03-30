import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final bool hideBottomBar;
  final double width;  // Changed to double
  final double height;  // Changed to double
  final String text;

  ColorBox({
    this.hideBottomBar = true,
    this.width = 250.0,  // Default value updated to double
    this.height = 100.0,  // Default value updated to double
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,  // Changed to use width
        height: height,  // Changed to use height
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Unbounded',
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
