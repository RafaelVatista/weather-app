import 'package:weather_app_v2/data/data_sources/weather/object/current_location_weather_response_model.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/weather-model.dart';

abstract class IIWeatherDataSourceCommon {}

//Interfaces specific to remote data source
abstract class IIWeatherDataSourceRemote implements IIWeatherDataSourceCommon {
  Future<WeatherResponse> getWeatherDetails(int cityId);
  Future<CurrentLocationWeatherResponse> getWeatherDetailsByLatLon({required double latitude, required double longitude});
}

//interfaces specific to local data source
abstract class IIWeatherDataSourceLocal implements IIWeatherDataSourceCommon {}

//interfaces specific to the main repository object. (cache operations, for example). Inherits both Remote and Local as those data sources are accessed via the repository.
abstract class IWeatherDataSourceRepository
    implements IIWeatherDataSourceRemote, IIWeatherDataSourceLocal {}
