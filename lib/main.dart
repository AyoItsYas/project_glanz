import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import the flutter_svg package
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart' as path; // Import path with an alias
import 'auth/page.dart';
import 'features/closet-page/page.dart';
import 'main-screen.dart';
import 'components/navigator.dart';
import 'features/closet-page/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Closet',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // AMOLED black
        canvasColor: Colors.black,
        cardColor: Colors.black,
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[900], // Dark button color
            foregroundColor: Colors.white, // Text color
          ),
        ),
        dialogTheme: DialogThemeData(backgroundColor: Colors.black),
      ),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // Start off-screen above
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    // Simulating a splash screen with a delay before transitioning to the home page
    _checkDatabase();
  }

  Future<void> _checkDatabase() async {
    // Path to the database file
    String dbPath = path.join(await getDatabasesPath(), 'glanz_db.db');

    if (await File(dbPath).exists()) {
      // Database exists, proceed to HomePage
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    } else {
      // Database does not exist, show a popup
      Future.delayed(const Duration(seconds: 3), () {
        _showDatabaseError();
      });
    }
  }

  void _showDatabaseError() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return AlertDialog(
          title: const Text('Database Missing'),
          content: const Text('The required database does not exist.'),
          actions: [
            TextButton(
              onPressed:
                  () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  RegUi()),
                  ),
              child: const Text('Sign In or Create Account'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SlideTransition(
          position: _slideAnimation,
          child: SvgPicture.asset(
            'lib/assets/logo.svg', // Ensure the path to your SVG is correct
            height: 100, // You can adjust the size as needed
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomNavigator();
  }
}
