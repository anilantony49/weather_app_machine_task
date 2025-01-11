import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  Widget getWeatherIcon(int? code) {
    if (code == null) return Image.asset('assets/8.png');
    if (code >= 200 && code < 300) return Image.asset('assets/1.png');
    if (code >= 300 && code < 400) return Image.asset('assets/2.png');
    if (code >= 400 && code < 500) return Image.asset('assets/3.png');
    if (code >= 500 && code < 600) return Image.asset('assets/4.png');
    if (code >= 600 && code < 700) return Image.asset('assets/5.png');
    if (code == 800) return Image.asset('assets/6.png');
    if (code > 800 && code <= 804) return Image.asset('assets/7.png');
    return Image.asset('assets/8.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          // Decorative Background
          Stack(
            children: [
              Align(
                alignment: const Alignment(-0.8, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.8, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.8),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(color: Color(0xfffffab40)),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter location',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.grey[800],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      context.read<WeatherBlocBloc>().add(
                            FetchWeatherByCity(value),
                          );
                    }
                  },
                ),
                const SizedBox(height: 20),
                // Weather Information
                Expanded(
                  child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                    builder: (context, state) {
                      if (state is WeatherBlocLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      } else if (state is WeatherBlocSuccess) {
                        return _buildWeatherInfo(state.weather);
                      } else if (state is WeatherBlocFailure) {
                        return const Center(
                          child: Text(
                            'Failed to fetch weather data. Try again.',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return const Center(
                        child: Text(
                          'Search for a location to view weather.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo(Weather weather) {
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
        const SizedBox(height: 20),
        // const Text(
        //   "Weather Details",
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildWeatherDetail("Humidity", "${weather.humidity ?? '--'}%"),
            _buildWeatherDetail("Pressure", "${weather.pressure ?? '--'} hPa"),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildWeatherDetail(
                "Wind Speed", "${weather.windSpeed ?? '--'} m/s"),
            _buildWeatherDetail("Cloudiness", "${weather.cloudiness ?? '--'}%"),
          ],
        ),
      ],
    );
  }

  Widget _buildWeatherDetail(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
