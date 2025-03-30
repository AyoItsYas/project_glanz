import 'package:flutter/material.dart';
import '../../components/pill.dart';
import '../../components/cool-card.dart';

class LaundryView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Pill(
              text: "Calendar",
              width: 340,
              height: 285,
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pill(
                  text: "Today's Weather [Dev]",
                  width: 160,
                  height: 100,
                ),
                SizedBox(width: 20),
                Pill(
                  text: "Today's Wind [Dev]",
                  width: 160,
                  height: 100,
                )
              ]
            ),
            SizedBox(height: 20),
            Pill(
              text: "Hourly Weather Container",
              width: 340,
              height: 150,
            )
          ],
        )
      ),
    );
  }
}