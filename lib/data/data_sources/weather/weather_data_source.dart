

import 'package:weather_app_v2/data/data_sources/weather/object/weather-model.dart';

abstract class IIWeatherDataSourceCommon {}

//Interfaces specific to remote data source
abstract class IIWeatherDataSourceRemote
    implements IIWeatherDataSourceCommon {
      Future<WeatherResponse> getWeatherDetails(int cityId);

}

//interfaces specific to local data source
abstract class IIWeatherDataSourceLocal
    implements IIWeatherDataSourceCommon {}

//interfaces specific to the main repository object. (cache operations, for example). Inherits both Remote and Local as those data sources are accessed via the repository.
abstract class IWeatherDataSourceRepository
    implements IIWeatherDataSourceRemote, IIWeatherDataSourceLocal {}
