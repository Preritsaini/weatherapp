import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';
import 'widgets/weather_card.dart';

class HomeView extends StatelessWidget {
  final controller = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    controller.loadLastCity();

    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        actions: [
          IconButton(
            icon: Icon(Get.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: controller.toggleTheme,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(),

            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              } else if (controller.error.isNotEmpty) {
                return Text(controller.error.value,
                    style: TextStyle(color: Colors.red));
              } else if (controller.weather.value != null) {
                return WeatherCard();
              } else {
                return Text('Search a city');
              }
            }),
          ],
        ),
      ),
    );
  }
}
