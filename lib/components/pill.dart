import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  final bool hideBottomBar;

  Pill({this.hideBottomBar = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                "12/15",
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