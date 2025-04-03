import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../components/cool-button.dart';
import '../../components/cool-card.dart';
import '../../services/db_helper.dart';

class Settings extends StatelessWidget {
  Future<void> _resetAppData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // print("App data wiped");

    await DatabaseHelper.instance.deleteDB();
    // print("Database deleted");

    // Restart the app by navigating to the initial route
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

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
            CoolButton(
              text: "Reset App Data",
              width: 340,
              onPressed: () => _resetAppData(context),
            ),
          ],
        ),
      ),
    );
  }
}
