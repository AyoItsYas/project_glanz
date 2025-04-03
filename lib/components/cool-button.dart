import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class CoolButton extends StatefulWidget {
  final String text;
  final double height;
  final double width;
  final String weather;
  final String subtext;
  final List<String>? WeatherModeStrings;
  final VoidCallback? onPressed;

  const CoolButton({
    super.key,
    required this.text,
    this.width = 100,
    this.height = 50,
    this.weather = "",
    this.WeatherModeStrings,
    this.subtext = "",
    this.onPressed,
  });

  @override
  _CoolButtonState createState() => _CoolButtonState();
}

class _CoolButtonState extends State<CoolButton> {
  bool isPressed = false;

  Icon getWeatherIcon(String weather) {
    switch (weather.toLowerCase()) {
      case 'sunny':
        return Icon(WeatherIcons.day_sunny, color: Colors.yellow, size: 24);
      case 'cloudy':
        return Icon(WeatherIcons.day_cloudy, color: Colors.grey, size: 24);
      case 'rainy':
        return Icon(WeatherIcons.day_rain, color: Colors.blue, size: 24);
      case 'snowy':
        return Icon(WeatherIcons.day_snow, color: Colors.white, size: 24);
      case 'windy':
        return Icon(WeatherIcons.day_windy, color: Colors.blueGrey, size: 24);
      default:
        return Icon(Icons.help_outline, color: Colors.black, size: 0);
    }
  }

  Widget showWeatherTable(List<String>? weatherStrings) {
    if (weatherStrings == null || weatherStrings.isEmpty) {
      return SizedBox.shrink();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            weatherStrings.map((weather) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    getWeatherIcon(weather.split("\n")[1]),
                    SizedBox(height: 5),
                    SizedBox(width: 10),
                    Text(
                      weather.split("\n")[0],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Unbounded",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: Center(
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: isPressed ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.text,
                          style: TextStyle(
                            color: isPressed ? Colors.white : Colors.black,
                            fontFamily: 'Unbounded',
                            fontSize: 18,
                          ),
                        ),
                        if (widget.subtext != "")
                          Text(
                            widget.subtext,
                            style: TextStyle(
                              color: isPressed ? Colors.grey : Colors.black54,
                              fontFamily: 'Unbounded',
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                    getWeatherIcon(widget.weather),
                  ],
                ),
              ),
              if (widget.WeatherModeStrings != null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [showWeatherTable(widget.WeatherModeStrings)],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
