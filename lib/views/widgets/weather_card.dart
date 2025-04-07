import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/weather_controller.dart';

class WeatherCard extends StatelessWidget {
  final controller = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    final data = controller.weather.value!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(data.city,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Image.network(
              'http://openweathermap.org/img/wn/${data.icon}@2x.png',
              width: 80,
              height: 80,
            ),
            Text('${data.temperature}°C',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300)),
            Text(data.condition),
            SizedBox(height: 8),
            Text('Humidity: ${data.humidity}%'),
            Text('Wind: ${data.wind} m/s'),
          ],
        ),
      ),
    );
  }
}
