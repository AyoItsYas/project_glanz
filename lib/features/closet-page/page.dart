import 'package:flutter/material.dart';
import '../../components/cool-card.dart';
import '../../components/pill.dart';
import '../../components/color-box.dart';

class ClosetView extends StatelessWidget {
  const ClosetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the data structure for each card with more specific types
    final cardData = [
      {
        'imagePath': 'lib/assets/demo.png',
        'bottomText': "Usage Statistics",
        'progressValues': [0.9, 0.33],
        'progressTexts': ["Cycles", "Yeet"],
      },
      {
        'imagePath': 'lib/assets/demo2.png',
        'bottomText': "Statistics Overview",
        'progressValues': [0.6, 0.5],
        'progressTexts': ["Cycles", "Yeet"],
      },
      // Add more card data here as needed
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
                    width: 300,
                    height: 450,
                    bottomText: cardData[index]['bottomText'] as String,
                    progressValues: List<double>.from(cardData[index]['progressValues'] as List),
                    progressTexts: List<String>.from(cardData[index]['progressTexts'] as List),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Pill(),
            SizedBox(height: 20),
            ColorBox(),
          ],
        ),
      ),
    );
  }
}
