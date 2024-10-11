import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/current_location_weather_response_model.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/weather-model.dart';
import 'package:weather_app_v2/data/data_sources/weather/weather_data_source.dart';
import 'package:http/http.dart' as http;

class WeatherRepositoryRemoteDataSource implements IIWeatherDataSourceRemote {
  static WeatherRepositoryRemoteDataSource? _instance;
  static WeatherRepositoryRemoteDataSource getInstance() {
    _instance ??= WeatherRepositoryRemoteDataSource();
    return _instance!;
  }

  @override
  Future<WeatherResponse> getWeatherDetails(int cityId) async {
    final String apiKey = dotenv.env['API_KEY'] ?? 'default_value';
    const String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';

    final response =
        await http.get(Uri.parse('$baseUrl?id=$cityId&APPID=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WeatherResponse.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }

  @override
  Future<CurrentLocationWeatherResponse> getWeatherDetailsByLatLon(
      {required double latitude, required double longitude}) async {
    final String apiKey = dotenv.env['API_KEY'] ?? 'default_value';
    const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

    final response = await http
        .get(Uri.parse('$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CurrentLocationWeatherResponse.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
