import 'package:weather_app_v2/data/data_sources/weather/object/current_location_weather_response_model.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/weather_model.dart';

import 'package:weather_app_v2/data/data_sources/weather/weather_data_source.dart';

class WeatherApiService {
  WeatherApiService(this.weatherDataSource);

  IWeatherDataSourceRepository weatherDataSource;

  Future<WeatherResponse> fetchWeather(int cityId) async {
    return await weatherDataSource.getWeatherDetails(cityId);
  }

  Future<CurrentLocationWeatherResponse> fetchWeatherByLatAndLon(
      {required double latitude, required double longitude}) async {
    return await weatherDataSource.getWeatherDetailsByLatLon(
        latitude: latitude, longitude: longitude);
  }
}
