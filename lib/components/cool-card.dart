import 'package:flutter/material.dart';
import 'progress.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CoolCard extends StatefulWidget {
  final bool hideBottomBar;
  final double width;
  final double height;
  final List<double>? progressValues;
  final List<String>? progressTexts;
  final String? bottomText;
  final MainAxisAlignment alignment;
  final String imagePath;
  final String bottomSubtext;
  final bool isRotatable;

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
    this.bottomSubtext = "", // Default empty string
    this.isRotatable = false,
  });

  @override
  _CoolCardState createState() => _CoolCardState();
}

class _CoolCardState extends State<CoolCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showBottomBar =
        (!widget.hideBottomBar &&
            (widget.progressValues != null || widget.bottomText != null));
    bool isSvg = widget.imagePath.endsWith('.svg');

    Widget imageWidget =
        isSvg
            ? SvgPicture.asset(
              widget.imagePath,
              width: widget.width * 0.5,
              height: widget.height * 0.5,
            )
            : Image.asset(
              widget.imagePath,
              width: widget.width * 0.8,
              height: widget.height * 0.8,
            );

    return Center(
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
                        widget.isRotatable
                            ? AnimatedBuilder(
                              animation: _rotationController,
                              builder: (context, child) {
                                return Transform.rotate(
                                  angle:
                                      _rotationController.value *
                                      2 *
                                      -3.141592653589793,
                                  child: child,
                                );
                              },
                              child: imageWidget,
                            )
                            : imageWidget,
                  ),
                ),
              ),
            ),

            if (showBottomBar)
              Container(
                width: double.infinity,
                height: widget.height * 0.35,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: const Border(
                    top: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: widget.alignment,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.bottomText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.bottomText!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Unbounded',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    if (widget.progressValues != null &&
                        widget.progressTexts != null)
                      ...List.generate(widget.progressValues!.length, (index) {
                        String text =
                            (index < widget.progressTexts!.length)
                                ? widget.progressTexts![index]
                                : 'No text';
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: CustomProgressBar(
                            progress: widget.progressValues![index],
                            text: text,
                          ),
                        );
                      }),
                    if (widget.bottomSubtext.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.bottomSubtext,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Unbounded',
                            fontSize: 14,
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
