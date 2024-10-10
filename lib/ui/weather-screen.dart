import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:weather_app_v2/ui/weather-view-model.dart';

enum Locations {
  lisboa('Lisboa', 2267056),
  leiria('Leiria', 2267094),
  coimbra('Coimbra', 2740636),
  porto('Porto', 2735941),
  faro('Faro', 2268337);

  const Locations(this.location, this.locationId);
  final String location;
  final int locationId;
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final expenseModel =
          Provider.of<WeatherViewModel>(context, listen: false);

      expenseModel.fetchWeather(2267056);
    });
  }

  @override
  Widget build(BuildContext context) {
    final expenseModel = Provider.of<WeatherViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        title: const Text("Weather"),
      ),
      body: Column(
        children: [
          expenseModel.loading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    Text(
                        "City: ${expenseModel.weather?.city?.name ?? "dffdff"}")
                  ],
                )
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       DropdownButton<Locations>(
          //         value: Locations.leiria,
          //         icon: const Icon(Icons.arrow_downward),
          //         elevation: 16,
          //         style: const TextStyle(color: Colors.deepPurple),
          //         underline: Container(
          //           height: 2,
          //           color: Colors.deepPurpleAccent,
          //         ),
          //         onChanged: (Locations? value) {
          //           // This is called when the user selects an item.
          //           setState(() {
          //             value!;
          //           });
          //         },
          //         items: Locations.values
          //             .map<DropdownMenuItem<Locations>>((Locations value) {
          //           return DropdownMenuItem<Locations>(
          //             value: value,
          //             child: Text(value.location),
          //           );
          //         }).toList(),
          //       ),
          //     ],
          //   ),
          //),
        ],
      ),
    );
  }
}
