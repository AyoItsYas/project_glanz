
import 'package:flutter/material.dart';
import '../../components/CoolCard.dart';

class ClosetView extends StatelessWidget {
  const ClosetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CoolCard(hideBottomBar: false),
      ),
    );
  }
}
