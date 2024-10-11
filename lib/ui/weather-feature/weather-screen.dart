import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weather_app_v2/core/utils/enums.dart';
import 'package:weather_app_v2/core/utils/utils.dart';
import 'package:weather_app_v2/data/data_sources/weather/object/weather-model.dart';
import 'package:weather_app_v2/ui/common/image-widget.dart';

import 'package:weather_app_v2/ui/weather-feature/weather-view-model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<void>? _weatherFuture;

  TemperatureUnits? _unitSelected = TemperatureUnits.celsius;
  Locations? _locationSelected = Locations.leiria;

  @override
  void initState() {
    super.initState();
    final weatherProvider =
        Provider.of<WeatherViewModel>(context, listen: false);
    _weatherFuture = weatherProvider.fetchWeather(Locations.leiria.locationId);
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherViewModel>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        body: Container(
          decoration: BoxDecoration(
            gradient: Utils.getWeatherCorrespondingColor(
                weatherProvider.weatherCondition ?? ""),
          ),
          child: FutureBuilder(
            future: _weatherFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error fetching data'));
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      style: BorderStyle.solid,
                                      width: 2),
                                ),
                                child: DropdownButton<Locations>(
                                  value: _locationSelected,
                                  onChanged: (Locations? newLocal) {
                                    _locationSelected = newLocal;
                                    weatherProvider
                                        .fetchWeather(newLocal!.locationId);
                                  },
                                  items: Locations.values
                                      .map<DropdownMenuItem<Locations>>(
                                          (Locations item) {
                                    return DropdownMenuItem<Locations>(
                                      value: item,
                                      child: Text(
                                        item.location,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      style: BorderStyle.solid,
                                      width: 2),
                                ),
                                child: DropdownButton<num>(
                                  value: weatherProvider.selectedDateTime,
                                  onChanged: (num? newValue) {
                                    weatherProvider
                                        .updateSelectedDateTime(newValue!);
                                  },
                                  items: weatherProvider.weatherData!
                                      .map<DropdownMenuItem<num>>(
                                          (ListOfWeather item) {
                                    return DropdownMenuItem<num>(
                                      value: item.dt,
                                      child: Text(
                                          Utils.formatUnixTimestamp(
                                                  item.dt ?? 0)
                                              .formatDate(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  style: BorderStyle.solid,
                                  width: 2),
                            ),
                            child: DropdownButton(
                              items: TemperatureUnits.values
                                  .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value.unit,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ))
                                  .toList(),
                              onChanged: (TemperatureUnits? value) {
                                setState(() {
                                  _unitSelected = value;
                                });
                              },
                              isExpanded: false,
                              value: _unitSelected,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      Expanded(
                        child: Column(
                          children: [
                            WeatherImageWidget(
                                image: weatherProvider.weatherIcon),
                            const SizedBox(height: 10),
                            if (weatherProvider.weatherCondition != null)
                              Text(
                                weatherProvider.weatherCondition!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            if (weatherProvider.weatherDescription != null)
                              Text(
                                weatherProvider.weatherDescription!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                              ),
                            const SizedBox(height: 20),
                            if (weatherProvider.selectedTemp != null)
                              Text(
                                'Temperature: ${Utils.convertToTemperatureUnit(_unitSelected ?? TemperatureUnits.celsius, weatherProvider.selectedTemp ?? 0.0)} ${_unitSelected?.identificationSymbol}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
