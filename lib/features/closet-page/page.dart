import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package
import '../../components/cool-card.dart';
import '../../components/pill.dart';
import '../../components/color-box.dart';

class ClosetView extends StatefulWidget {
  const ClosetView({super.key});

  @override
  State<ClosetView> createState() => _ClosetViewState();
}

class _ClosetViewState extends State<ClosetView> {
  final PageController _pageController =
      PageController(); // Controller for PageView

  @override
  Widget build(BuildContext context) {
    final cardData = [
      {
        'imagePath': 'lib/assets/warning.svg',
        'bottomText': "Usage Statistics",
        'progressValues': [0.0, 0.0],
        'progressTexts': ["Cycles", "Times in Laundry"],
      },
      {
        'imagePath': 'lib/assets/warning.svg',
        'bottomText': "Usage Statistics",
        'progressValues': [0.0, 0.0],
        'progressTexts': ["Cycles", "Times in Laundry"],
      },
    ];

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 450,
              child: PageView.builder(
                controller: _pageController,
                itemCount: cardData.length,
                itemBuilder: (context, index) {
                  return CoolCard(
                    imagePath: cardData[index]['imagePath'] as String,
                    hideBottomBar: false,
                    width: 340,
                    height: 420,
                    bottomText: cardData[index]['bottomText'] as String,
                    progressValues: List<double>.from(
                      cardData[index]['progressValues'] as List,
                    ),
                    progressTexts: List<String>.from(
                      cardData[index]['progressTexts'] as List,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Pill(text: "15/17"),
            const SizedBox(height: 10),

            // SmoothPageIndicator for dots
            SmoothPageIndicator(
              controller: _pageController,
              count: cardData.length,
              effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.white,
                dotColor: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),
            ColorBox(height: 100, width: 300),
          ],
        ),
      ),
    );
  }
}
