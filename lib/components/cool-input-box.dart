import 'package:flutter/material.dart';

class CoolInputBox extends StatefulWidget {
  final String placeholder;
  final double height;
  final double width;
  final String inputType;
  final String subtext;
  final TextEditingController? controller;
  final VoidCallback? onSubmitted;
  final bool obscureText;

  const CoolInputBox({
    super.key,
    required this.placeholder,
    this.height = 50,
    this.width = 250,
    this.inputType = "text",
    this.subtext = "",
    this.controller,
    this.onSubmitted,
    this.obscureText = false,
  });

  @override
  _CoolInputBoxState createState() => _CoolInputBoxState();
}

class _CoolInputBoxState extends State<CoolInputBox> {
  bool isFocused = false;
  bool isObscured = true;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText; // Set initial obscure state
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: isFocused ? Colors.black87 : Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: widget.controller,
                  keyboardType:
                      widget.inputType == "number"
                          ? TextInputType.number
                          : TextInputType.text,
                  obscureText: isObscured, // Hide text if true
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(
                      color: isFocused ? Colors.white70 : Colors.white54,
                      fontFamily: 'Unbounded',
                      fontSize: 16,
                    ),
                    suffixIcon:
                        widget.obscureText
                            ? IconButton(
                              icon: Icon(
                                isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white54,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscured = !isObscured;
                                });
                              },
                            )
                            : null, // Only show eye icon if `obscureText` is true
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
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
              if (widget.subtext.isNotEmpty)
                Positioned(
                  bottom: 5,
                  left: 10,
                  child: Text(
                    widget.subtext,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontFamily: 'Unbounded',
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
