import 'dart:convert';

import 'package:weatherapp/weather.dart';
import 'package:http/http.dart' as http;

class Weatherservice{
  String cityname="Trivandrum";

  final String apikey;

  Weatherservice(this.apikey);

  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=a6920cb083f7613503664bb55f51eefd&units=metric'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Weather.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}