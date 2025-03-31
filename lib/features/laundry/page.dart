import 'package:flutter/material.dart';
import '../../components/pill.dart';
import '../../components/cool-card.dart';
import 'package:table_calendar/table_calendar.dart';

class LaundryView extends StatelessWidget {
  const LaundryView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView( // Add SingleChildScrollView here
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pill(
                    text: "Rainy ",
                    weather: "rainy",
                    width: screenWidth * 0.45,
                    height: 100,
                  ),
                  SizedBox(width: 20),
                  Pill(
                    text: "8km/h ",
                    weather: 'windy',
                    width: screenWidth * 0.45,
                    height: 100,
                  )
                ],
              ),
              SizedBox(height: 20),
              Pill(
                text: "",
                WeatherModeStrings: ["Monday\nsunny", "Tuesday\nwindy", "Wednesday\ncloudy", "Thursday\nsnowy", "Friday\nsunny", "Saturday\nsunny", "Sunday\nrainy"],
                width: screenWidth * 0.95,
                height: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}
