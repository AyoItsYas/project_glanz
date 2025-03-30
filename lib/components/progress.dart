import 'package:flutter/material.dart';

class CustomProgressBar extends StatelessWidget {
  final double progress; // Progress value between 0.0 and 1.0
  final String? text; // Optional text to display
  final TextStyle? textStyle; // Optional text style

  const CustomProgressBar({
    Key? key,
    required this.progress,
    this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (text != null)
          Text(
            text!,
            style: textStyle ??
                TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontFamily: "Unbounded",
                ),
          ),
        SizedBox(height: 2), // Spacing between text and bar
        Container(
          height: 20,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
