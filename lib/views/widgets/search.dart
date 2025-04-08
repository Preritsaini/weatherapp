import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/weather_controller.dart';

class SearchBar extends StatelessWidget {
  final WeatherController controller = Get.find<WeatherController>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(
            hintText: "Enter city name",
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                final city = textController.text.trim();
                if (city.isNotEmpty) {
                  controller.fetchWeather(city);
                }
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onFieldSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              controller.fetchWeather(value.trim());
            }
          },
        ),
      ),
    );
  }
}
