import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String API_KEY;

  WeatherService(this.API_KEY);

  // Fetch weather using latitude and longitude
  Future<Weather> getWeather(double latitude, double longitude) async {
    final response = await http.get(
      Uri.parse('$BASE_URL?lat=$latitude&lon=$longitude&appid=$API_KEY&units=metric'),
    );

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data: ${response.body}');
    }
  }

  // Get the current position and locality (city name)
  Future<Map<String, dynamic>> getCurrentPositionAndLocality() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        throw Exception('Location permissions are denied.');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String locality = placemarks.isNotEmpty && placemarks[0].locality != null
        ? placemarks[0].locality!
        : 'Unknown Location';

    // Return both position and locality
    return {
      'position': position,
      'locality': locality,
    };
  }
}
