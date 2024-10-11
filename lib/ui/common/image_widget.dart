import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app_v2/core/utils/utils.dart';

class WeatherImageWidget extends StatefulWidget {
  const WeatherImageWidget({this.icon, this.gif, super.key});

  final String? icon;
  final String? gif;

  @override
  State<WeatherImageWidget> createState() => _WeatherImageWidgetState();
}

class _WeatherImageWidgetState extends State<WeatherImageWidget> {
  late Future<LottieComposition>? _composition;

  @override
  void initState() {
    super.initState();
    _loadGif();
  }

  @override
  void didUpdateWidget(covariant WeatherImageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gif != widget.gif) {
      _loadGif();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _composition = null;
  }

  void _loadGif() {
    if (widget.gif != null) {
      _composition = AssetLottie(
        Utils.getAnimatedWeatherConditon(widget.gif!),
      ).load();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget widgetToReturn = Center(
      child: Icon(
        Icons.error_outline,
        color: Theme.of(context).colorScheme.error,
        size: 30,
      ),
    );

    if (widget.icon == null || widget.gif == null) {
      return widgetToReturn;
    }

    if (widget.gif != null || widget.gif != "") {
      widgetToReturn = FutureBuilder<LottieComposition>(
        future: _composition,
        builder: (context, snapshot) {
          var composition = snapshot.data;
          if (composition != null) {
            return Lottie(
              composition: composition,
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            );
          } else if (snapshot.hasError) {
            return Image.network(
              'https://openweathermap.org/img/wn/${widget.icon}@2x.png',
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error_outline,
                    color: Theme.of(context).colorScheme.error);
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
    }

    return widgetToReturn;
  }
}
