import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';


class WeatherController extends GetxController {
  var weather = Rxn<WeatherModel>();
  var isLoading = false.obs;
  var error = ''.obs;
  final city = ''.obs;
  final storage = GetStorage();

  void fetchWeather(String inputCity) async {
    try {
      isLoading.value = true;
      error.value = '';
      city.value = inputCity;
      final data = await WeatherService.fetchWeather(inputCity);
      weather.value = data;
      storage.write('lastCity', inputCity);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void loadLastCity() {
    final lastCity = storage.read('lastCity');
    if (lastCity != null) {
      fetchWeather(lastCity);
    }
  }

  void toggleTheme() {
    final isDark = Get.isDarkMode;
    Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
    storage.write('isDark', !isDark);
  }
}
