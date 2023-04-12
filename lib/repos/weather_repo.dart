import 'package:dio/dio.dart';
import 'package:flutter_megacom_final/models/weather_response.dart';

class WeatherRepo {
  WeatherRepo({required this.dio});
  final Dio dio;

  Future<WeatherResponse> fetchWeather() async {
    final Response response = await dio.get('');
    final WeatherResponse result = WeatherResponse.fromJson(response.data);
    return result;
  }
}
