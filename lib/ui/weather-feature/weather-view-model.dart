import 'package:flutter/material.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/current_location_weather_response_model.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/weather-model.dart';
import 'package:weather_app_v2/data/data_sources/weather/weather_repository.dart';

import 'package:weather_app_v2/data/weather-api-service.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherApiService _weatherApiService =
      WeatherApiService(WeatherRepository.getInstance());

  WeatherResponse? _weather;
  WeatherResponse? get weather => _weather;

  CurrentLocationWeatherResponse? _currentLocationWeather;
  CurrentLocationWeatherResponse? get currentLocationWeather =>
      _currentLocationWeather;

  List<ListOfWeather>? _weatherData;
  List<ListOfWeather>? get weatherData => _weatherData;

  num? _selectedDateTime;
  num? get selectedDateTime => _selectedDateTime;

  double? _selectedTemp;
  double? get selectedTemp => _selectedTemp;

  String? _weatherCondition;
  String? get weatherCondition => _weatherCondition;

  String? _weatherDescription;
  String? get weatherDescription => _weatherDescription;

  String? _weatherIcon;
  String? get weatherIcon => _weatherIcon;

  Future<void> fetchWeather(int cityId) async {
    try {
      _weather = await _weatherApiService.fetchWeather(cityId);

      _weatherData = _weather?.list;

      if (_weatherData?.isNotEmpty ?? false) {
        _selectedDateTime = weatherData?.first.dt;
        _selectedTemp = weatherData?.first.main?.temp?.toDouble();
        _weatherCondition = weatherData?.first.weather?.first.main;
        _weatherDescription = weatherData?.first.weather?.first.description;
        _weatherIcon = weatherData?.first.weather?.first.icon;
      }
    } catch (e) {
      throw (e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchWeatherByCurrentLocation(
      {required double latitude, required double longitude}) async {
    try {
      _currentLocationWeather = await _weatherApiService
          .fetchWeatherByLatAndLon(latitude: latitude, longitude: longitude);

      if (_currentLocationWeather != null) {
        _selectedTemp = _currentLocationWeather?.main?.temp?.toDouble();
        _weatherCondition = _currentLocationWeather?.weather?.first.main;
        _weatherDescription =
            _currentLocationWeather?.weather?.first.description;
        _weatherIcon = _currentLocationWeather?.weather?.first.icon;
      }
    } catch (e) {
      throw (e.toString());
    } finally {
      notifyListeners();
    }
  }

  void updateSelectedDateTime(num newDateTime) {
    _selectedDateTime = newDateTime;
    final selectedData = _weatherData?.firstWhere(
      (element) => element.dt == selectedDateTime,
    );
    _selectedTemp = selectedData?.main?.temp?.toDouble();
    _weatherCondition = selectedData?.weather?.first.main;
    _weatherDescription = selectedData?.weather?.first.description;
    _weatherIcon = selectedData?.weather?.first.icon;
    notifyListeners();
  }
}
