import 'package:weather/weather.dart';

class WeatherService {
  static const String _apiKey = 'f2baabef94301d5906bbd3c58df9fc3b';
  static const String _city = 'Colombo';

  Future<List<Weather>> getWeeklyForecast() async {
    try {
      WeatherFactory wf = WeatherFactory(_apiKey, language: Language.ENGLISH);
      List<Weather> forecast = await wf.fiveDayForecastByCityName(_city);
      // Get one forecast per day
      List<Weather> dailyForecasts = [];
      DateTime? lastDate;

      for (var weather in forecast) {
        if (lastDate == null ||
            weather.date!.year != lastDate.year ||
            weather.date!.month != lastDate.month ||
            weather.date!.day != lastDate.day) {
          dailyForecasts.add(weather);
          lastDate = weather.date;
        }
      }

      return dailyForecasts;
    } catch (e) {
      print('Error fetching weather data: $e');
      return [];
    }
  }

  Future<Weather> getCurrentWeather() async {
    try {
      WeatherFactory wf = WeatherFactory(_apiKey, language: Language.ENGLISH);
      Weather weather = await wf.currentWeatherByCityName(_city);
      return weather;
    } catch (e) {
      print('Error fetching current weather: $e');
      throw Exception('Failed to fetch weather data');
    }
  }
}
