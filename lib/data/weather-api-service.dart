import 'package:weather_app_v2/data/data_sources/weather/object/weather-model.dart';

import 'package:weather_app_v2/data/data_sources/weather/weather_data_source.dart';

class WeatherApiService {
  WeatherApiService(this.weatherDataSource);

  IWeatherDataSourceRepository weatherDataSource;

  Future<WeatherResponse> fetchWeather(int cityId) async {
    return await weatherDataSource.getWeatherDetails(cityId);
  }


}
