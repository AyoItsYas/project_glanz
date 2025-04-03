import 'package:flutter/material.dart';
import 'package:project_glanz/components/cool-button.dart';
import '../components/cool-card.dart';
import 'question.dart';
import 'package:flutter/services.dart';
import '../main.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 1),
              child: const CoolCard(
                imagePath: 'lib/assets/greeter.png',
                height: 500,
                width: 340,
                bottomText: 'A little bit of how to...',
                hideBottomBar: false,
                bottomSubtext:
                    '''Our app is designed to make outfit planning effortless by combining fashion, laundry management, and real-time weather updates.''',
              ),
            ),
            const SizedBox(height: 20),
            CoolButton(
              text: "Go to Home",
              width: 300,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
