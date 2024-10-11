import 'package:flutter/material.dart';

class WeatherImageWidget extends StatelessWidget {
  const WeatherImageWidget({this.image, super.key});

  final String? image;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return const SizedBox();
    }

    return Image.network(
      'https://openweathermap.org/img/wn/$image@2x.png',
      width: 150,
      height: 150,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error_outline,
            color: Theme.of(context).colorScheme.error);
      },
    );
  }
}
