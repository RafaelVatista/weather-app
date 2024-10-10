import 'package:flutter/material.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/weather-model.dart';
import 'package:weather_app_v2/data/data_sources/weather/weather_repository.dart';

import 'package:weather_app_v2/data/weather-api-service.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherApiService _weatherApiService =
      WeatherApiService(WeatherRepository.getInstance());

  bool _loading = false;
  bool get loading => _loading;

  WeatherResponse? _weather;
  WeatherResponse? get weather => _weather;

  Future<void> fetchWeather(int cityId) async {
    _loading = true;
    notifyListeners();

    try {
      _weather = await _weatherApiService.fetchWeather(cityId);
      print(_weather?.city?.name);
    } catch (e) {
      // Handle error
      print(e.toString());
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
