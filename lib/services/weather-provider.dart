import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherProvider {
  static const String _apiKey = "f2baabef94301d5906bbd3c58df9fc3b";
  static const String _city = "Colombo";

  Future<Map<String, String>> fetchWeatherData() async {
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$_city&units=metric&appid=$_apiKey";
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
}
