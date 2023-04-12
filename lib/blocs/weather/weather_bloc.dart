// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_megacom_final/models/weather_response.dart';
import 'package:flutter_megacom_final/repos/weather_repo.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.repo}) : super(WeatherInitial()) {
    on<GetWeatherEvent>((event, emit) async {
      try {
        emit(WeatherLoading());
        final response = await repo.fetchWeather();
        emit(WeatherSuccess(response: response));
      } catch (e) {
        emit(WeatherError());
      }
    });
  }
  final WeatherRepo repo;
}
