class WeatherModel {
  final String city;
  final double temperature;
  final String condition;
  final String icon;
  final int humidity;
  final double wind;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.condition,
    required this.icon,
    required this.humidity,
    required this.wind,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      wind: json['wind']['speed'].toDouble(),
    );
  }
}
