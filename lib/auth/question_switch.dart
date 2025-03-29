import 'package:flutter/material.dart';
import 'package:project_glanz/components/cool-button.dart';
import 'package:project_glanz/components/cool-input-box.dart';
import '../components/cool-card.dart';
import '../services/db_helper.dart';
import 'package:project_glanz/auth/welcome.dart';
import '../auth/question.dart';

class Question_Switch extends StatefulWidget {
  const Question_Switch({super.key});

  @override
  _QuestionState_Switch createState() => _QuestionState_Switch();
}

class _QuestionState_Switch extends State<Question_Switch> {
  Offset _offset = const Offset(0, 1);
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _offset = Offset.zero;
      });
    });
  }

  // Function to log in the user
  void _loginUser() async {
    String fullName = _fullNameController.text.trim();
    String password = _passwordController.text;

    if (fullName.isEmpty || password.isEmpty) {
      _showDialog("Error", "Both fields are required.");
      return;
    }

    try {
      bool isAuthenticated = await DatabaseHelper.instance.authenticateUser(
        fullName,
        password,
      );

      if (isAuthenticated) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) => const WelcomeView(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      } else {
        _showDialog("Error", "Invalid username or password.");
      }
    } catch (e) {
      _showDialog("Error", "Login failed: ${e.toString()}");
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Center(
            child: AnimatedSlide(
              offset: _offset,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      const CoolCard(
                        imagePath: 'lib/assets/logo.svg',
                        height: 300,
                        width: 340,
                        bottomText: "Let's Get Things Ready!",
                        hideBottomBar: false,
                        bottomSubtext: 'All your data is stored locally...',
                      ),
                      const SizedBox(height: 20),
                      CoolInputBox(
                        placeholder: "Enter Your Full Name",
                        controller: _fullNameController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      CoolInputBox(
                        placeholder: "Enter Password",
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      CoolButton(
                        text: "Log In",
                        width: 300,
                        onPressed: _loginUser,
                      ),
                      const SizedBox(height: 10),
                      CoolButton(
                        text: "Switch User",
                        width: 300,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const Question(),
                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
