import 'package:flutter/material.dart';
import '../../components/pill.dart';
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Pill(
                              text:
                                  "Current\n${_currentWeather!.temperature?.celsius?.toStringAsFixed(1)}°C",
                              subtext:
                                  "Feels like: ${_currentWeather!.tempFeelsLike?.celsius?.toStringAsFixed(1)}°C",
                              weather: _getWeatherIcon(
                                _currentWeather!.weatherMain,
                              ),
                              width: screenWidth * 0.45,
                              height: 120,
                            ),
                            SizedBox(width: 20),
                            Pill(
                              text: "Wind\n${_currentWeather!.windSpeed} km/h",
                              subtext:
                                  "Humidity: ${_currentWeather!.humidity}%",
                              weather: 'windy',
                              width: screenWidth * 0.45,
                              height: 120,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Pill(
                          text: "Details",
                          subtext:
                              "Pressure: ${_currentWeather!.pressure} hPa\nClouds: ${_currentWeather!.cloudiness}%",
                          width: screenWidth * 0.95,
                          height: 100,
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  if (_weeklyForecast.isNotEmpty)
                    Column(
                      children:
                          _weeklyForecast.take(5).map((weather) {
                            final date = weather.date;
                            if (date == null) return SizedBox.shrink();

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

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Pill(
                                text:
                                    "$day\n${weather.temperature?.celsius?.toStringAsFixed(1)}°C",
                                subtext:
                                    "Humidity: ${weather.humidity}%\nWind: ${weather.windSpeed} km/h",
                                weather: _getWeatherIcon(weather.weatherMain),
                                width: screenWidth * 0.95,
                                height: 120,
                              ),
                            );
                          }).toList(),
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
