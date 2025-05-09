import 'package:flutter/material.dart';
import '../../components/cool-card.dart';

class QuickMatchView extends StatelessWidget {
  const QuickMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CoolCard(
              imagePath: 'lib/assets/demo.png',
              hideBottomBar: true,
              width: 340,
              height: 290,
            ),
            SizedBox(height: 20),
            CoolCard(
              imagePath: 'lib/assets/demo-pants.png',
              hideBottomBar: true,
              width: 340,
              height: 290,
            ),
          ],
        ),
      ),
    );
  }
}
