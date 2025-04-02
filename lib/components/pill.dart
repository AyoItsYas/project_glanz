import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Pill extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final String weather;
  final String subtext;
  final List<String>? WeatherModeStrings;

  const Pill({
    super.key,
    required this.text,
    this.width = 100,
    this.height = 50,
    this.weather = "",
    this.WeatherModeStrings,
    this.subtext = "",
  });

  // Define the getWeatherIcon function outside the build method
  Icon getWeatherIcon(String weather) {
    switch (weather.toLowerCase()) {
      case 'sunny':
        return Icon(
          WeatherIcons.day_sunny,
          color: Colors.yellow,
          size: 24,
        );
      case 'cloudy':
        return Icon(
          WeatherIcons.day_cloudy,
          color: Colors.grey,
          size: 24,
        );
      case 'rainy':
        return Icon(
          WeatherIcons.day_rain,
          color: Colors.blue,
          size: 24,
        );
      case 'snowy':
        return Icon(
          WeatherIcons.day_snow,
          color: Colors.white,
          size: 24,
        );
      case 'windy':
        return Icon(
          WeatherIcons.day_windy,
          color: Colors.blueGrey,
          size: 24,
        );
      default:
        return Icon(
          Icons.help_outline,
          color: Colors.black,
          size: 0,
        );
    }
  }

  // Method to display a horizontally scrollable table
  Widget showWeatherTable(List<String>? weatherStrings) {
    if (weatherStrings == null || weatherStrings.isEmpty) {
      return SizedBox.shrink(); // Return an empty widget if the list is null or empty
    }
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: weatherStrings.map((weather) {
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
                    color: Colors.white,
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
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black,
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
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Unbounded',
                          fontSize: 18,
                        ),
                      ),
                      if (subtext != "")
                        Text(
                          subtext,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Unbounded',
                            fontSize: 14,
                          ),
                        )
                    ]
                  ),
                  getWeatherIcon(weather),
                ],
              ),
            ),
            if (WeatherModeStrings != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showWeatherTable(WeatherModeStrings),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
