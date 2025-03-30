import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  final String text;
  final double height;
  final double width;

  Pill({
    required this.text,
    this.width = 100, 
    this.height = 50,
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
          children: [
            Center(
              child:
                Text(
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
