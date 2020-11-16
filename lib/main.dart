import 'package:clima/services/weather_data_getter.dart';
import 'package:clima/constants.dart';
import 'package:clima/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
  //weather_data_getter data = new weather_data_getter();
  //await data.get_weather_data();
  //print(data.weather_data_set);
}


class MyApp extends StatelessWidget {
  @override
  final Future<weather_data_getter> post;
  MyApp({Key key, this.post}) : super(key: key);
  
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Application',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        primaryColor:primaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor:textColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
