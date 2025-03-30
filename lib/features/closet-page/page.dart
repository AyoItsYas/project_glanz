import 'package:flutter/material.dart';
import '../../components/cool-card.dart';
import '../../components/pill.dart';
import '../../components/color-box.dart';

class ClosetView extends StatelessWidget {
  const ClosetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoolCard(
              imagePath: 'lib/assets/demo.png',
              hideBottomBar: false,
              width: 300,
              height: 450,
              bottomText: "Usage Statistics",
              progressValues: [0.9, 0.33],
              progressTexts: ["Cycles", "Yeet"],
            ),
            SizedBox(height: 20),
            Pill(),
            SizedBox(height:20),
            ColorBox(),
          ],
        ),
      ),
    );
  }
}
