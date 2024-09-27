class Weather {
  final String cityName;
  final double temp;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.temp,
    required this.mainCondition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '', // Default to empty string if not found
      temp: (json['main']['temp'] as num).toDouble(), // Ensure it's treated as a number
      mainCondition: json['weather'] != null && json['weather'].isNotEmpty
          ? json['weather'][0]['main']
          : 'Unknown', // Default if not found
    );
  }
}
