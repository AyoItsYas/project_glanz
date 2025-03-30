import 'package:flutter/material.dart';
import 'components/cool-card.dart';
import 'components/pill.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CoolCard(
                    imagePath: 'lib/assets/demo.png',
                    height: 350,
                    width: 340,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the pills horizontally
                    children: [
                      Pill(
                        text: "Dev\nbuild",
                        width: 100,
                        height: 220,
                      ),
                      SizedBox(width: 20), // Add some space between pills
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Pill(
                            text: "Dev\nbuild",
                            width: 220,
                            height: 80,
                          ),
                          SizedBox(height: 20), // Add space between pills
                          Pill(
                            text: "Dev\nbuild",
                            width: 220,
                            height: 120,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
