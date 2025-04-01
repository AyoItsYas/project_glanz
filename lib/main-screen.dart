import 'package:flutter/material.dart';
import 'components/cool-card.dart';
import 'components/pill.dart';
import 'services/db_helper.dart'; // Import your database helper

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  String _firstName = "User"; // Default value before fetching

  @override
  void initState() {
    super.initState();
    _fetchUserName();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward(); // Start the animation
  }

  Future<void> _fetchUserName() async {
    try {
      String fullName = await DatabaseHelper.instance.getUserFullName(); // Replace with your DB query
      List<String> nameParts = fullName.split(" ");
      setState(() {
        _firstName = nameParts.isNotEmpty ? nameParts[0] : fullName; // Extract first name
      });
    } catch (e) {
      print("Error fetching name: $e");
    }
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
                          bottomSubtext: 'Welcome to Glanz, We will help you come out of the closet',
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
                          subtext: "\nWind_\n8km/h\n\nTemp_\n20C",
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
                                text: "Monday ",
                                weather: "sunny",
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
                                subtext: "T-Shirt X Shorts",
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
