import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/weather_controller.dart';

class SearchBar extends StatelessWidget {
  final controller = Get.find<WeatherController>();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: "Enter city name",
        suffixIcon: IconButton(
          icon: Icon(Icons.search,color: Colors.black,),
          onPressed: () {
            controller.fetchWeather(textController.text);
          },
        ),
        border: OutlineInputBorder(),
      ),
      onSubmitted: (value) {
        controller.fetchWeather(value);
      },
    );
  }
}
