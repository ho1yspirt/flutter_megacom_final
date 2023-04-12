import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_megacom_final/blocs/weather/weather_bloc.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const CircularProgressIndicator();
        }
        if (state is WeatherSuccess) {
          final double tempK = state.response.main?.temp ?? 0;
          final double tempC = tempK - 273.15;
          final double tempF = tempK * 9 / 5 - 459.67;
          return Text(
            'Weather for ${state.response.sys?.country}, ${state.response.name}: ${tempC.toStringAsFixed(2)}c (${tempF.toStringAsFixed(2)}F)',
            textAlign: TextAlign.center,
          );
        }
        if (state is WeatherError) {
          return const Icon(Icons.error_outline);
        }
        return const Text('Press Weather icon to get weather');
      },
    );
  }
}
