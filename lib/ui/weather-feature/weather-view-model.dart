import 'package:flutter/material.dart';
import 'package:weather_app_v2/core/utils/utils.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/weather-model.dart';
import 'package:weather_app_v2/data/data_sources/weather/weather_repository.dart';

import 'package:weather_app_v2/data/weather-api-service.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherApiService _weatherApiService =
      WeatherApiService(WeatherRepository.getInstance());

  WeatherResponse? _weather;
  WeatherResponse? get weather => _weather;

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
        _selectedTemp = weatherData?.first.main?.temp;
        _weatherCondition = weatherData?.first.weather?.first.main;
        _weatherDescription = weatherData?.first.weather?.first.description;
        _weatherIcon = weatherData?.first.weather?.first.icon;

        var a = DateTime.fromMillisecondsSinceEpoch(
                _weatherData!.first!.dt!.toInt() * 1000)
            .formatDate();

        print(a);
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
    _selectedTemp = selectedData?.main?.temp;
    _weatherCondition = selectedData?.weather?.first.main;
    _weatherDescription = selectedData?.weather?.first.description;
    _weatherIcon = selectedData?.weather?.first.icon;
    notifyListeners();
  }
}
