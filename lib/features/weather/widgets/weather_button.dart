import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_megacom_final/blocs/weather/weather_bloc.dart';

class WeatherButton extends StatelessWidget {
  const WeatherButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        BlocProvider.of<WeatherBloc>(context).add(
          GetWeatherEvent(),
        );
      },
      child: const Icon(Icons.cloud_outlined),
    );
  }
}
