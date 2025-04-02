import 'package:flutter/material.dart';
import '../../components/cool-card.dart';
import '../../components/pill.dart';
import '../../components/color-box.dart';

class ClosetView extends StatelessWidget {
  const ClosetView({super.key});

  @override
  Widget build(BuildContext context) {
    final cardData = [
      {
        'imagePath': 'lib/assets/demo.png',
        'bottomText': "Usage Statistics",
        'progressValues': [0.9, 0.33],
        'progressTexts': ["Cycles", "Times in Laundry"],
      },
      {
        'imagePath': 'lib/assets/demo2.png',
        'bottomText': "Usage Statistics",
        'progressValues': [0.6, 0.5],
        'progressTexts': ["Cycles", "Times in Laundry"],
      },
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // PageView to swipe between cards
            SizedBox(
              height: 450,
              child: PageView.builder(
                itemCount: cardData.length,
                itemBuilder: (context, index) {
                  return CoolCard(
                    imagePath: cardData[index]['imagePath'] as String,
                    hideBottomBar: false,
                    width: 340,
                    height: 420,
                    bottomText: cardData[index]['bottomText'] as String,
                    progressValues: List<double>.from(cardData[index]['progressValues'] as List),
                    progressTexts: List<String>.from(cardData[index]['progressTexts'] as List),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Pill(
              text: "15/17"
            ),
            SizedBox(height: 10),
            ColorBox(
              height: 100,
              width: 300,
            ),
          ],
        ),
      ),
    );
  }
}
