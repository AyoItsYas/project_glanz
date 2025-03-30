import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final bool hideBottomBar;
  final int _width;
  final int _height;
  final String text;

  ColorBox({
    this.hideBottomBar = true,
    this._width = 200,
    this._height = 150,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 0.5),
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