part of 'weather_bloc_bloc.dart';

@immutable
sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

// Fetch weather by geographic coordinates
class FetchWeatherByLocation extends WeatherBlocEvent {
  final Position position;

  const FetchWeatherByLocation(this.position);

  @override
  List<Object> get props => [position];
}

// Fetch weather by city name
class FetchWeatherByCity extends WeatherBlocEvent {
  final String cityName;

  const FetchWeatherByCity(this.cityName);

  @override
  List<Object> get props => [cityName];
}
