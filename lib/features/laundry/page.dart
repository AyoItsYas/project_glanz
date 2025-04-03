import 'package:flutter/material.dart';
import '../../components/pill.dart';
import '../../components/cool-card.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../services/weather_service.dart';
import 'package:weather/weather.dart';

class LaundryView extends StatefulWidget {
  const LaundryView({super.key});

  @override
  State<LaundryView> createState() => _LaundryViewState();
}

class _LaundryViewState extends State<LaundryView> {
  final WeatherService _weatherService = WeatherService();
  List<Weather> _weeklyForecast = [];
  Weather? _currentWeather;
  bool _isLoading = true;
  DateTime? _selectedDay;
  bool _showImage = false;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    try {
      final currentWeather = await _weatherService.getCurrentWeather();
      final weeklyForecast = await _weatherService.getWeeklyForecast();
      setState(() {
        _currentWeather = currentWeather;
        _weeklyForecast = weeklyForecast;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading weather data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getWeatherIcon(String? weather) {
    switch (weather?.toLowerCase()) {
      case 'clear':
        return 'sunny';
      case 'clouds':
        return 'cloudy';
      case 'rain':
        return 'rainy';
      case 'snow':
        return 'snowy';
      default:
        return 'sunny';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _showImage = true;
                      });
                    },
                    rowHeight: 40.0,
                  ),
                  SizedBox(height: 20),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else if (_currentWeather != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Pill(
                          text: "${_currentWeather!.weatherMain ?? 'Unknown'} ",
                          weather: _getWeatherIcon(
                            _currentWeather!.weatherMain,
                          ),
                          width: screenWidth * 0.45,
                          height: 100,
                        ),
                        SizedBox(width: 20),
                        Pill(
                          text: "${_currentWeather!.windSpeed ?? 0}km/h ",
                          weather: 'windy',
                          width: screenWidth * 0.45,
                          height: 100,
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (_weeklyForecast.isNotEmpty)
                    Pill(
                      text: "",
                      WeatherModeStrings:
                          _weeklyForecast.take(5).map((weather) {
                            final date = weather.date;
                            if (date == null) return "Unknown\nsunny";

                            final day =
                                date.weekday == 1
                                    ? 'Monday'
                                    : date.weekday == 2
                                    ? 'Tuesday'
                                    : date.weekday == 3
                                    ? 'Wednesday'
                                    : date.weekday == 4
                                    ? 'Thursday'
                                    : date.weekday == 5
                                    ? 'Friday'
                                    : date.weekday == 6
                                    ? 'Saturday'
                                    : 'Sunday';
                            return "$day\n${_getWeatherIcon(weather.weatherMain)}";
                          }).toList(),
                      width: screenWidth * 0.95,
                      height: 150,
                    ),
                ],
              ),
            ),
          ),
          if (_showImage)
            Container(
              color: Colors.black.withOpacity(0.9),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'lib/assets/demo.png',
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.7,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _showImage = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
