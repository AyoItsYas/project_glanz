import 'package:flutter/material.dart';
import 'package:project_glanz/components/cool-button.dart';
import 'package:project_glanz/components/cool-input-box.dart';
import '../components/cool-card.dart';
import '../services/db_helper.dart';
import 'package:project_glanz/auth/welcome.dart';
import '../auth/question_switch.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Offset _offset = const Offset(0, 1);
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _offset = Offset.zero;
      });
    });
  }

  void _createUser() async {
    String fullName = _fullNameController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (fullName.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showDialog("Error", "All fields are required.");
      return;
    }

    if (password != confirmPassword) {
      _showDialog("Error", "Passwords do not match.");
      return;
    }

    try {
      await DatabaseHelper.instance.createUser(fullName, password);
      _showDialog("Success", "User created successfully!");
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) => const WelcomeView(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } catch (e) {
      _showDialog("Error", "User creation failed: ${e.toString()}");
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
                        width: 340,
                        placeholder: "Enter Your Full Name",
                        controller: _fullNameController,
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),
                      CoolInputBox(
                        width: 340,
                        placeholder: "Enter Password",
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      CoolInputBox(
                        width: 340,
                        placeholder: "Confirm Password",
                        controller: _confirmPasswordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),
                      CoolButton(
                        text: "Create User",
                        width: 340,
                        onPressed: _createUser,
                      ),
                      const SizedBox(height: 10),
                      CoolButton(
                        text: "Switch User",
                        width: 340,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const Question_Switch(),
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
