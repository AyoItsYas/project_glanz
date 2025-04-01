import 'package:flutter/material.dart';
import 'package:project_glanz/components/cool-button.dart';
import '../components/cool-card.dart';
import 'question.dart';

class RegUi extends StatefulWidget {
  const RegUi({super.key});

  @override
  _RegUiState createState() => _RegUiState();
}

class _RegUiState extends State<RegUi> {
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
                imagePath: 'lib/assets/logo.svg',
                height: 400,
                width: 340,
                bottomText: 'Welcome To Glanz !',
                hideBottomBar: false,
                bottomSubtext: '#1 Closet Management Application',
              ),
            ),
            const SizedBox(height: 20),
            CoolButton(
              text: "Press here to continue",
              width: 300,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const Question(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}