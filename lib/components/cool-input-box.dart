import 'package:flutter/material.dart';

class CoolInputBox extends StatefulWidget {
  final String placeholder;
  final double height;
  final double width;
  final String inputType;
  final String subtext;
  final TextEditingController? controller;
  final VoidCallback? onSubmitted;

  const CoolInputBox({
    super.key,
    required this.placeholder,
    this.height = 50,
    this.width = 250,
    this.inputType = "text",
    this.subtext = "",
    this.controller,
    this.onSubmitted, required bool obscureText,
  });

  @override
  _CoolInputBoxState createState() => _CoolInputBoxState();
}

class _CoolInputBoxState extends State<CoolInputBox> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: isFocused ? Colors.black : Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: widget.controller,
                      keyboardType: widget.inputType == "number"
                          ? TextInputType.number
                          : TextInputType.text,
                      textAlign: TextAlign.center, // Centering the text input
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.placeholder,
                        hintStyle: TextStyle(
                          color: isFocused ? Colors.white : Colors.white,
                          fontFamily: 'Unbounded', // Set font to 'Unbounded'
                          fontSize: 18,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isFocused = true;
                        });
                      },
                      onEditingComplete: () {
                        if (widget.onSubmitted != null) {
                          widget.onSubmitted!();
                        }
                      },
                    ),
                    if (widget.subtext != "")
                      Text(
                        widget.subtext,
                        style: TextStyle(
                          color: isFocused ? Colors.black54 : const Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Unbounded', // Set font to 'Unbounded'
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
