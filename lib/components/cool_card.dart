import 'package:flutter/material.dart';

class CoolCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            "Black Cool Card",
            style: TextStyle(color: Colors.white, fontFamily: 'Unbounded', fontSize: 18),
          ),
        ),
      ),
    );
  }
}
