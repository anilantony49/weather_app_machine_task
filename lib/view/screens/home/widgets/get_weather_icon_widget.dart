  import 'package:flutter/material.dart';

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