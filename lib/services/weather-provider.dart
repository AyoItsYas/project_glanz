import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_glanz/services/db_helper.dart';

class WeatherProvider {
  static const String _apiKey = "<API_KEY>";

  Future<Map<String, String>> fetchWeatherData() async {
    // Fetch the city name from the database
    String city = await _getLocationFromDatabase();

    final String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$_apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          "temperature": "${data['main']['temp']}°C",
          "windSpeed": "${data['wind']['speed']} km/h",
          "weatherCondition": data['weather'][0]['main'],
        };
      } else {
        throw Exception("Failed to fetch weather data");
      }
    } catch (e) {
      print("Error fetching weather data: $e");
      return {
        "temperature": "--",
        "windSpeed": "--",
        "weatherCondition": "Unknown",
      };
    }
  }

  Future<String> _getLocationFromDatabase() async {
    final String location = await DatabaseHelper.instance.getUserLocation();
    return location.isNotEmpty ? location : "Colombo";
  }
}
