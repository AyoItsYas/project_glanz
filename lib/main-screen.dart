import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'components/cool-card.dart';
import 'components/pill.dart';
import 'services/db_helper.dart';
import 'services/weather-provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  String _firstName = "User";
  String _lastCombo = "Unavailable";
  String _temperature = "--";
  String _windSpeed = "--";
  String _weatherCondition = "Unknown";

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    _checkAndFetchLastCombo();
    _fetchWeatherData();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();

    // Set loggedInStat to true in the user_status table
    _setLoggedInStatus();
  }

  Future<void> _setLoggedInStatus() async {
    try {
      // Assuming you have a method in your DatabaseHelper to update the user status
      await DatabaseHelper.instance.updateLoggedInStatus(
        true,
      ); // Set loggedInStat to true
    } catch (e) {
      print("Error updating loggedInStat: $e");
    }
  }

  Future<void> _fetchUserName() async {
    try {
      String fullName = await DatabaseHelper.instance.getUserFullName();
      List<String> nameParts = fullName.split(" ");
      setState(() {
        _firstName = nameParts.isNotEmpty ? nameParts[0] : fullName;
      });
    } catch (e) {
      print("Error fetching name: $e");
    }
  }

  Future<void> _checkAndFetchLastCombo() async {
    try {
      bool tableExists = await DatabaseHelper.instance.checkIfTableExists(
        "outfits",
      );
      if (tableExists) {
        List<Map<String, dynamic>> result = await DatabaseHelper.instance
            .getDataFromTable("outfits");
        if (result.isNotEmpty) {
          setState(() {
            _lastCombo = "${result.last['top']} X ${result.last['bottom']}";
          });
        }
      }
    } catch (e) {
      print("Error fetching last combo: $e");
      setState(() {
        _lastCombo = "An Error Occurred!";
      });
    }
  }

  Future<void> _fetchWeatherData() async {
    WeatherProvider weatherProvider = WeatherProvider();
    Map<String, String> weatherData = await weatherProvider.fetchWeatherData();
    setState(() {
      _temperature = weatherData["temperature"]!;
      _windSpeed = weatherData["windSpeed"]!;
      _weatherCondition = weatherData["weatherCondition"]!;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: CoolCard(
                          imagePath: 'lib/assets/logo.svg',
                          hideBottomBar: false,
                          bottomText: 'Hi $_firstName!',
                          bottomSubtext:
                              'Welcome to Glanz, We will help you come out of the closet',
                          height: 350,
                          width: 340,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Pill(
                          text: "Env...",
                          subtext:
                              "\nWind_\n$_windSpeed\n\nTemp_\n$_temperature",
                          width: 100,
                          height: 220,
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              child: Pill(
                                text: "Today ",
                                weather: _weatherCondition,
                                width: 220,
                                height: 80,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: ScaleTransition(
                              scale: _scaleAnimation,
                              child: Pill(
                                text: "Last Combo",
                                subtext: _lastCombo,
                                width: 220,
                                height: 120,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
