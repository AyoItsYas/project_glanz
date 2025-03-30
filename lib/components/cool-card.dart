import 'package:flutter/material.dart';
import 'progress.dart';

class CoolCard extends StatelessWidget {
  final bool hideBottomBar;
  final double width;
  final double height;
  final List<double>? progressValues;
  final List<String>? progressTexts;
  final String? bottomText;
  final MainAxisAlignment alignment;
  final String imagePath;

  CoolCard({
    this.hideBottomBar = true,
    this.width = 200.0,
    this.height = 150.0,
    this.progressValues,
    this.progressTexts,
    this.bottomText,
    this.alignment = MainAxisAlignment.center,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    bool showBottomBar = (!hideBottomBar && (progressValues != null || bottomText != null));

    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imagePath,
                    width: width * 0.8,
                    height: height * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            if (showBottomBar)
              Container(
                width: double.infinity,
                height: height * 0.35,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7), 
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: alignment,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (bottomText != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          bottomText!,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Unbounded',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (progressValues != null && progressTexts != null)
                      ...List.generate(progressValues!.length, (index) {
                        String text = (index < progressTexts!.length) ? progressTexts![index] : 'No text';
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: CustomProgressBar(
                            progress: progressValues![index],
                            text: text,
                          ),
                        );
                      }),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
