import 'package:flutter/material.dart';
import '../../components/cool-button.dart';
import '../../components/cool-card.dart';
import '../../components/pill.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Pill(text: "Ometh Abeyrathne", height: 100, width: 340),
          ],
        ),
      ),
    );
  }
}
