import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String apiKey = 'a8bf15d693fdfd9f2ac3096713d0a7f0'; // Ganti dengan API key dari OpenWeather
  late WeatherFactory weatherFactory;
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    weatherFactory = WeatherFactory(apiKey);
    fetchWeather();
  }

  void fetchWeather() async {
    Weather weather = await weatherFactory.currentWeatherByCityName("Harlem");
    setState(() {
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _weather == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.3), // gelapkan sedikit background agar teks terbaca
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Harlem',
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  'Tuesday, Januari 10, 2019',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 20),
                Text(
                  '${_weather!.temperature!.celsius!.round()}°C',
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Divider(
                  height: 40,
                  color: Colors.white70,
                  thickness: 1,
                  indent: 60,
                  endIndent: 60,
                ),
                Text(
                  '${_weather!.weatherMain}',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  '${_weather!.tempMin!.celsius!.round()}°C / ${_weather!.tempMax!.celsius!.round()}°C',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
