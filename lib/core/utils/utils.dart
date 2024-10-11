import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_v2/core/utils/enums.dart';

class Utils {
  static String convertToTemperatureUnit(
      TemperatureUnits unit, double temperatureToConvert) {
    switch (unit) {
      case TemperatureUnits.celsius:
        return (temperatureToConvert - 273.15).toStringAsFixed(1);
      case TemperatureUnits.fahrenheit:
        return ((temperatureToConvert - 273.15) * 9 / 5 + 32)
            .toStringAsFixed(1);
      default:
        return temperatureToConvert.toStringAsFixed(1);
    }
  }

  static LinearGradient getWeatherCorrespondingColor(String weatherCondition) {
    switch (weatherCondition.toLowerCase()) {
      case 'thunderstorm':
        return const LinearGradient(
          colors: [Colors.grey, Colors.blueGrey, Colors.amber],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
      case 'drizzle':
        return const LinearGradient(
          colors: [Colors.grey, Colors.blueGrey, Colors.blue],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
      case 'rain':
        return const LinearGradient(
          colors: [Colors.blueGrey, Colors.indigo],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
      case 'snow':
        return const LinearGradient(
          colors: [Colors.white, Colors.blueGrey],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
      case 'mist':
        return const LinearGradient(
          colors: [Colors.blueGrey, Colors.grey],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
      case 'clear':
        return const LinearGradient(
          colors: [Colors.white, Colors.lightBlueAccent],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
      case 'clouds':
        return const LinearGradient(
          colors: [Colors.white, Colors.grey],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
      default:
        return const LinearGradient(
          colors: [Colors.lightBlue, Colors.blue],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        );
    }
  }

  static DateTime formatUnixTimestamp(num timestamp) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp.toInt() * 1000);
    return date;
  }
}

extension DateTimeExtension on DateTime {
  String formatDate() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy').add_Hms();
    return formatter.format(this);
  }
}
