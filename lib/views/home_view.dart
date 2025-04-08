import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';
import 'widgets/weather_card.dart';
import 'package:flutter/services.dart';

class HomeView extends StatelessWidget {
  final controller = Get.find<WeatherController>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.loadLastCity();
    final isDark = Get.isDarkMode;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        ),
        title: Text(
          "Weather Forecast",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.grey[800]!.withOpacity(0.5)
                  : Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              icon: Icon(
                Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDark ? Colors.amber : Colors.indigo,
              ),
              onPressed: controller.toggleTheme,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Colors.grey[900]!, Colors.grey[800]!]
                : [Colors.blue[200]!, Colors.blue[50]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Featured cities or "Quick access" cards
                  SizedBox(
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildQuickCityButton("New York"),
                        _buildQuickCityButton("London"),
                        _buildQuickCityButton("Tokyo"),
                        _buildQuickCityButton("Paris"),
                        _buildQuickCityButton("Sydney"),
                      ],
                    ),
                  ),
              
                  SizedBox(height: 24),
              
                  // Search section with decorative card
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.grey[800]!.withOpacity(0.7)
                          : Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Find Weather",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        // Search Field
                        TextFormField(
                          controller: textController,
                          decoration: InputDecoration(
                            hintText: "Enter city name",
                            prefixIcon: Icon(Icons.search, color: Colors.blue),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey),
                              onPressed: () => textController.clear(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: isDark
                                ? Colors.grey[700]
                                : Colors.grey[200],
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          onFieldSubmitted: _searchWeather,
                        ),
                        SizedBox(height: 16),
                        // Search Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => _searchWeather(textController.text),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_outlined),
                                SizedBox(width: 8),
                                Text(
                                  "Get Weather",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              
                  SizedBox(height: 24),
              
                  // Weather Result
                  SingleChildScrollView(
                    child: Expanded(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                    strokeWidth: 3,
                                  ),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Fetching weather data...",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (controller.error.isNotEmpty) {
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    controller.error.value,
                                    style: TextStyle(
                                      color: Colors.red[700],
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () => controller.loadLastCity(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[50],
                                      foregroundColor: Colors.red[700],
                                    ),
                                    child: Text("Try again"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (controller.weather.value != null) {
                          return WeatherCard();
                        } else {
                          return _buildInitialState();
                        }
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _searchWeather(String value) {
    final city = value.trim();
    if (city.isNotEmpty) {
      controller.fetchWeather(city);
    } else {
      Get.snackbar(
        "Oops!",
        "Please enter a city name",
        backgroundColor: Colors.red.withOpacity(0.2),
        colorText: Colors.black,
        margin: EdgeInsets.all(16),
        borderRadius: 10,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    }
  }

  Widget _buildQuickCityButton(String cityName) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {
          textController.text = cityName;
          controller.fetchWeather(cityName);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.isDarkMode
              ? Colors.grey[800]
              : Colors.white.withOpacity(0.9),
          foregroundColor: Get.isDarkMode
              ? Colors.white
              : Colors.blue[700],
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(cityName),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.cloud_queue,
            size: 100,
            color: Get.isDarkMode ? Colors.white70 : Colors.blue[300],
          ),
          SizedBox(height: 16),
          Text(
            "How's the weather today?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Get.isDarkMode ? Colors.white70 : Colors.blue[800],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Search for a city to view current weather",
            style: TextStyle(
              fontSize: 16,
              color: Get.isDarkMode ? Colors.white60 : Colors.blue[600],
            ),
          ),
        ],
      ),
    );
  }
}