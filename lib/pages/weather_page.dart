import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_models.dart';
import 'package:minimal_weather_app/service/weather_service.dart';
import 'package:geolocator/geolocator.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('YOUR_API_KEY'); //apikey
  Weather? _weather;
  String _locality = 'Loading city...';

  //fetch weather
  _fetchWeather() async {
    try {
      final result = await _weatherService.getCurrentPositionAndLocality();
      Position position = result['position'];
      String locality = result['locality'];

      setState(() {
        _locality = locality;
      });

      final weather = await _weatherService.getWeather(
          position.latitude, position.longitude);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Rain.json';
      case 'thunder':
        return 'assets/Storm.json';
      case 'clear':
        return 'assets/Sunny.json';
      default:
        return 'assets/Sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF151515) : Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 90.0),
                child:
                    Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              ),
              Text(
                _locality,
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode
                      ? const Color(0xFFCCCCCC)
                      : const Color(0xFF000000),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_weather?.temp.round()}°C',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: isDarkMode
                            ? const Color(0xFFCCCCCC)
                            : const Color(0xFF000000)),
                  ),
                  const SizedBox(width: 0),
                  Text(
                    ' • ${_weather?.mainCondition}',
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF707070)),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
