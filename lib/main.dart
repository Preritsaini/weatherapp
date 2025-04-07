import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'controllers/weather_controller.dart'; // Import controller
import 'views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required before async
  await GetStorage.init(); // Init local storage

  // 👇 Put the controller directly
  Get.put(WeatherController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final isDark = box.read('isDark') ?? false;

    return GetMaterialApp(
      title: 'Weather App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
