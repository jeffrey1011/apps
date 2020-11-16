// Import the test package and Counter class
import 'package:flutter_test/flutter_test.dart';
import 'package:clima/services/weather.dart';

void main() {
  test('Load Weather', () async {
    var weatherData = await WeatherModel.getCityWeather("Hong Kong");

    print("Weather Data: $weatherData");
  });

  test('Counter value should be incremented', () {
    final counter = 1;

    expect(counter, 1);
  });
}
