import 'package:flutter/material.dart';
import 'progress.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoolCard extends StatelessWidget {
  final bool hideBottomBar;
  final double width;
  final double height;
  final List<double>? progressValues;
  final List<String>? progressTexts;
  final String? bottomText;
  final MainAxisAlignment alignment;
  final String imagePath;
  final String bottomSubtext;

  const CoolCard({
    super.key, 
    this.hideBottomBar = true,
    this.width = 200.0,
    this.height = 150.0,
    this.progressValues,
    this.progressTexts,
    this.bottomText,
    this.alignment = MainAxisAlignment.center,
    required this.imagePath,
    this.bottomSubtext = "", // Add default empty string
  });

  @override
  Widget build(BuildContext context) {
    bool showBottomBar = (!hideBottomBar && (progressValues != null || bottomText != null));

    // Check if the imagePath ends with .svg to decide if it's an SVG
    bool isSvg = imagePath.endsWith('.svg');

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
                  child: isSvg
                    ? SvgPicture.asset(
                        imagePath,
                        width: width * 0.2,
                        height: height * 0.2,
                      )
                    : Image.asset(
                        imagePath,
                        width: width * 0.8,
                        height: height * 0.8,
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
                    if (bottomSubtext.isNotEmpty) 
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          bottomSubtext,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Unbounded',
                            fontSize: 14, // smaller size for subtext
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
