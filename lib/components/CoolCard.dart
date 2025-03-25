import 'package:flutter/material.dart';

class CoolCard extends StatelessWidget {
  final bool hideBottomBar;

  CoolCard({this.hideBottomBar = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white, width: 0.5),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                "Black Cool Card",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Unbounded',
                  fontSize: 18,
                ),
              ),
            ),
            if (!hideBottomBar)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Bottom Bar",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Unbounded',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
