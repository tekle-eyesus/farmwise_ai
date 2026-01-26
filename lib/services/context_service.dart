import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContextService {
  // REPLACE WITH YOUR OPENWEATHERMAP API KEY
  static final String _apiKey = dotenv.env["OPENWEATHER_API_KEY"]!;

  /// 1. Get User's Current Position
  static Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // ask user to enable if not enabled

    if (!serviceEnabled) {
      return null; // Location services are disabled
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  /// 2. Get Readable Address (e.g., "Bishoftu, Oromia")
  static Future<String> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.locality}, ${place.administrativeArea}, Ethiopia";
      }
    } catch (e) {
      return "Unknown Location in Ethiopia";
    }
    return "Ethiopia";
  }

  /// 3. Fetch Detailed Weather & Forecast
  /// Returns a formatted String ready for the LLM
  static Future<String> fetchWeatherData(Position position) async {
    try {
      final lat = position.latitude;
      final lon = position.longitude;

      // A. Get Current Weather
      final currentUrl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');

      // B. Get Forecast (Next few days)
      final forecastUrl = Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&cnt=3'); // cnt=3 gets next 9 hours roughly, or increase count for days

      final currentRes = await http.get(currentUrl);
      final forecastRes = await http.get(forecastUrl);

      if (currentRes.statusCode == 200 && forecastRes.statusCode == 200) {
        final currentJson = json.decode(currentRes.body);
        final forecastJson = json.decode(forecastRes.body);

        // Parse Current
        double temp = currentJson['main']['temp'];
        int humidity = currentJson['main']['humidity'];
        double windSpeed = currentJson['wind']['speed'];
        String condition = currentJson['weather'][0]['description'];

        // Parse Forecast (Simple check for rain in next 24h)
        // We iterate through the list to see if rain is coming
        bool rainExpected = false;
        List<dynamic> list = forecastJson['list'];
        for (var item in list) {
          String fcCondition =
              item['weather'][0]['main'].toString().toLowerCase();
          if (fcCondition.contains('rain')) {
            rainExpected = true;
            break;
          }
        }

        // Construct Robust String for LLM
        return '''
        - Current Status: $condition
        - Temperature: ${temp.toStringAsFixed(1)}°C
        - Humidity: $humidity% (High humidity increases fungal risk)
        - Wind Speed: ${windSpeed.toStringAsFixed(1)} m/s
        - Short-term Forecast: ${rainExpected ? "Rain is expected soon." : "No rain expected in immediate forecast."}
        ''';
      } else {
        return "Weather data unavailable (API Error).";
      }
    } catch (e) {
      return "Weather data unavailable (Connection Error).";
    }
  }
}
