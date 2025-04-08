import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/weather_controller.dart';
import 'package:intl/intl.dart';

class WeatherCard extends StatelessWidget {
  final controller = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    final data = controller.weather.value!;
    final now = DateTime.now();
    final dateFormat = DateFormat('EEEE, MMM d');
    final currentDate = dateFormat.format(now);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        children: [
          // Main weather card
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _getBackgroundGradient(data.condition),
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location and date row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.white, size: 20),
                              SizedBox(width: 4),
                              Text(
                                data.city,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            currentDate,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        onPressed: () => controller.fetchWeather(data.city),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Temperature and condition
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Temperature section
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data.temperature}',
                                  style: TextStyle(
                                    fontSize: 72,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '°C',
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              data.condition,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        // Weather icon
                        Container(
                          width: 110,
                          height: 110,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(55),
                          ),
                          child: Image.network(
                            'http://openweathermap.org/img/wn/${data.icon}@2x.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Weather details
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildDetailItem(Icons.water_drop_outlined, '${data.humidity}%', 'Humidity'),
                        _verticalDivider(),
                        _buildDetailItem(Icons.air, '${data.wind} m/s', 'Wind'),
                        _verticalDivider(),
                        // _buildDetailItem(Icons.visibility, '${_getVisibility(data)} km', 'Visibility'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }

  // Helper method to determine background gradient based on weather condition
  List<Color> _getBackgroundGradient(String condition) {
    condition = condition.toLowerCase();

    if (condition.contains('clear') || condition.contains('sunny')) {
      return [Colors.blue[400]!, Colors.blue[700]!];
    } else if (condition.contains('cloud')) {
      return [Colors.blueGrey[300]!, Colors.blueGrey[700]!];
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      return [Colors.indigo[300]!, Colors.indigo[800]!];
    } else if (condition.contains('thunder')) {
      return [Colors.deepPurple[400]!, Colors.deepPurple[900]!];
    } else if (condition.contains('snow')) {
      return [Colors.lightBlue[200]!, Colors.lightBlue[700]!];
    } else if (condition.contains('mist') || condition.contains('fog')) {
      return [Colors.blueGrey[200]!, Colors.blueGrey[500]!];
    } else {
      return [Colors.blue[300]!, Colors.blue[700]!]; // Default
    }
  }

  // Placeholder for visibility data which might not be in your original model
  // String _getVisibility(dynamic data) {
  //   // If visibility is available in your model, use that instead
  //   return data.visibility?.toString() ?? '10'; // Default value
  // }
}