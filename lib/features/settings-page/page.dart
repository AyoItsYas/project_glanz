import 'package:flutter/material.dart';
import '../../components/cool-button.dart';
import '../../components/cool-card.dart';
import '../../components/pill.dart';
import '../../components/cool-button.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CoolCard(
              imagePath: "lib/assets/settings.svg",
              isRotatable: true,
              bottomText: "Ometh Abeyrathne",
              bottomSubtext: "Current User | [Development Build: 1.0.0:12]",
              hideBottomBar: false,
              height: 300,
              width: 340,
            ),
            SizedBox(height: 20),
            CoolButton(text: "Recalibrate Pairing Model", width: 340),
            SizedBox(height: 20),
            CoolButton(text: "Recalibrate Weather Location", width: 340),
            SizedBox(height: 20),
            CoolButton(text: "Log out", width: 340),
            SizedBox(height: 20),
            CoolButton(text: "Reset App Data", width: 340),
          ],
        ),
      ),
    );
  }
}
