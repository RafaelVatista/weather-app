import 'package:weather_app_v2/data/data_sources/weather/object/current_location_weather_response_model.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/weather_model.dart';
import 'package:weather_app_v2/data/data_sources/weather/remote/weather_remote_data_source.dart';
import 'package:weather_app_v2/data/data_sources/weather/weather_data_source.dart';

class WeatherRepository implements IWeatherDataSourceRepository {
  static WeatherRepository? _instance;
  static WeatherRepository getInstance() {
    _instance ??= WeatherRepository();
    return _instance!;
  }

  @override
  Future<WeatherResponse> getWeatherDetails(int cityId) async {
    final remoteInstance = WeatherRepositoryRemoteDataSource.getInstance();
    return await remoteInstance.getWeatherDetails(cityId);
  }

  @override
  Future<CurrentLocationWeatherResponse> getWeatherDetailsByLatLon(
      {required double latitude, required double longitude}) async {
    final remoteInstance = WeatherRepositoryRemoteDataSource.getInstance();
    return await remoteInstance.getWeatherDetailsByLatLon(
        latitude: latitude, longitude: longitude);
  }
}
