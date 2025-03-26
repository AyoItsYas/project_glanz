import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import '../../components/cool-button.dart';
import '../../components/cool-card.dart';
import '../../services/db_helper.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String _username = 'Guest';
  String _weatherLocation = 'Colombo';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadWeatherLocation();
  }

  // Load the username from the database
  Future<void> _loadUserName() async {
    String username = await DatabaseHelper.instance.getUserFullName();
    setState(() {
      _username = username;
    });
  }

  // Load the weather location from the database
  Future<void> _loadWeatherLocation() async {
    String location = await DatabaseHelper.instance.getUserLocation();
    setState(() {
      _weatherLocation = location.isNotEmpty ? location : 'Colombo';
    });
  }

  // Save the weather location to the database
  Future<void> _saveWeatherLocation(String newLocation) async {
    if (newLocation.isNotEmpty) {
      await DatabaseHelper.instance.saveUserLocation(newLocation);
      setState(() {
        _weatherLocation = newLocation; // Update the displayed location
      });
    }
  }

  Future<void> _resetAppData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    await DatabaseHelper.instance.deleteDB();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void _showLocationDialog() {
    TextEditingController _locationController = TextEditingController();
    _locationController.text = _weatherLocation;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Weather Location'),
          content: TextField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Enter New Weather Location',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String newLocation = _locationController.text.trim();
                _saveWeatherLocation(newLocation);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
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
              bottomText: _username,
              bottomSubtext: "Current User \n[Development Build: 1.0.0:12]",
              hideBottomBar: false,
              height: 320,
              width: 340,
            ),
            SizedBox(height: 20),
            CoolButton(
              text: "Change Weather Location",
              width: 340,
              onPressed: _showLocationDialog,
            ),
            SizedBox(height: 20),
            CoolButton(
              text: "Recalibrate Pairing Model",
              width: 340,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Uh Oh !'),
                      content: const Text(
                        'You have stumbled upon a future implementation! This feature is not yet available. :(',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: 20),
            CoolButton(
              text: "Log out",
              width: 340,
              onPressed: () => _resetAppData(context),
            ),
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
