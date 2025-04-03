import 'package:flutter/material.dart';
import '../../components/pill.dart';
import '../../components/cool-card.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../services/weather-provider.dart';

class LaundryView extends StatelessWidget {
  const LaundryView({super.key});

  Future<Map<String, String>> _fetchWeatherData() async {
    try {
      WeatherProvider weatherProvider = WeatherProvider();
      return await weatherProvider.fetchWeatherData();
    } catch (e) {
      if (e.toString().contains('no such table')) {
        throw 'Set Location First on Settings';
      } else {
        throw 'Error fetching weather data: $e';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
                rowHeight: 40.0,
              ),
              SizedBox(height: 20),
              // Use FutureBuilder to load weather data
              FutureBuilder<Map<String, String>>(
                future: _fetchWeatherData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    Map<String, String> weatherData = snapshot.data!;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pill(
                          text: "${weatherData["weatherCondition"]!} ",
                          weather: weatherData["weatherCondition"]!,
                          width: screenWidth * 0.45,
                          height: 100,
                        ),
                        SizedBox(width: 20),
                        Pill(
                          text: "${weatherData["windSpeed"]}",
                          weather: 'windy',
                          width: screenWidth * 0.45,
                          height: 100,
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 20),
              Pill(
                text: "",
                WeatherModeStrings: [
                  "Monday\nclear",
                  "Tuesday\nrain",
                  "Wednesday\nclouds",
                  "Thursday\nclouds",
                  "Friday\nrain",
                  "Saturday\nclear",
                  "Sunday\nclear",
                ],
                width: screenWidth * 0.95,
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
