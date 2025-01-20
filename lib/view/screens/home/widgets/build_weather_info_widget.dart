import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/view/screens/home/widgets/build_weather_detail_widget.dart';
import 'package:weather_app/view/screens/home/widgets/get_weather_icon_widget.dart';

Widget buildWeatherInfo(Weather weather) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '📍${weather.areaName}',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
      ),
      const SizedBox(height: 8),
      SizedBox(
        width: 100,
        height: 100,
        child: getWeatherIcon(weather.weatherConditionCode),
      ),
      Center(
        child: Text(
          '${weather.temperature!.celsius!.round()}°C',
          style: const TextStyle(
              color: Colors.white, fontSize: 55, fontWeight: FontWeight.w600),
        ),
      ),
      Center(
        child: Text(
          weather.weatherMain!.toUpperCase(),
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      const SizedBox(height: 5),
      Center(
        child: Text(
          DateFormat('EEEE dd •').add_jm().format(weather.date!),
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
        ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildWeatherDetail("Humidity", "${weather.humidity}%"),
          buildWeatherDetail("Pressure", "${weather.pressure} hPa"),
        ],
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildWeatherDetail("Wind Speed", "${weather.windSpeed} m/s"),
          buildWeatherDetail("Cloudiness", "${weather.cloudiness}%"),
        ],
      ),
    ],
  );
}
