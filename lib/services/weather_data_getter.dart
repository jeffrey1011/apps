import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class weather_data_getter {
  //get current location
  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  final String _api_adress ='https://api.openweathermap.org/data/2.5/onecall?' ;
  final String _api_key = '048c5a5c919d6c4f6f1a8779926a885a';
  String _lat = '22.3841824';
  String _lon = '113.9737372';
  String _units = 'metric';
  String _exclude = 'minutely,hourly,alerts';

  Map weather_data_set = new Map();

  //getter
  Map get weather_data_map => this.weather_data_set;

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _lat = position.latitude.toString();
      _lon = position.longitude.toString();
      }).catchError((e) {
      print(e);
    });
  }

  Future<void> get_weather_data() async {
   // init_map();
    //get the current location
    _getCurrentLocation();
    //set api address
    var url = '$_api_adress\lat=$_lat&lon=$_lon&units=$_units&exclude=$_exclude&appid=$_api_key';
    var httpClient = new HttpClient();

    String result;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
       await convert_jaon(data);

      } else {
        result = 'Error code ${response.statusCode}';
        print(result);
      }
    } catch (exception) {
      result = 'Failed of getting weather data';
      print(result);
    }
    return weather_data_set;
  }
  void convert_jaon (var response_data) async {
    weather_data_set['current_place'] = convert_place(response_data['timezone']);
    weather_data_set['current_date'] = covert_unixtime(response_data['current']['dt']);
    weather_data_set['current_temp'] = convert_temp(response_data['current']['temp']);
    weather_data_set['current_temp_feel'] = convert_temp(response_data['current']['feels_like']);
    weather_data_set['current_humidity'] = response_data['current']['humidity'];
    weather_data_set['current_clouds'] = response_data['current']['clouds'];
    weather_data_set['current_uvi'] = response_data['current']['uvi'];
    weather_data_set['current_wind_speed'] = response_data['current']['wind_speed'];
    weather_data_set['current_wind_deg'] = response_data['current']['wind_deg'];
    weather_data_set['current_weather'] = response_data['current']['weather'][0]['main'];
    weather_data_set['current_weather_desc'] = convert_desctoUpperCase(response_data['current']['weather'][0]['description']);
    weather_data_set['current_weather_img'] = convert_img_url(response_data['current']['weather'][0]['icon']);

    if(response_data['current']['weather'][0]['main'] == 'Rain')
      weather_data_set['current_rain'] = response_data['current']['rain']['1h'];
    //skip the first daily forecast

    for(int day = 1;day<response_data['daily'].length;day++) {
      weather_data_set['forecast_day_$day'] = {
        'date': covert_unixtime(response_data['daily'][day]['dt']),
        'gen_temp': convert_temp(response_data['daily'][day]['temp']['day']),
        'min_temp': convert_temp(response_data['daily'][day]['temp']['min']),
        'max_temp': convert_temp(response_data['daily'][day]['temp']['max']),
        'temp_feel': convert_temp(response_data['daily'][day]['feels_like']['day']),
        'humidity': response_data['daily'][day]['humidity'],
        'wind_speed': response_data['daily'][day]['wind_speed'],
        'weather': response_data['daily'][day]['weather'][0]['main'],
        'weather_desc': convert_desctoUpperCase(response_data['daily'][day]['weather'][0]['description']),
        'weather_img': convert_img_url(response_data['daily'][day]['weather'][0]['icon'])
      };
    }

  }
  // void init_map ()  {
  //   weather_data_set['current_place'] =null ;
  //   weather_data_set['current_date'] =null ;
  //   weather_data_set['current_temp'] =null;
  //   weather_data_set['current_temp_feel'] = null;
  //   weather_data_set['current_humidity'] = null;
  //   weather_data_set['current_clouds'] =null ;
  //   weather_data_set['current_uvi'] =null;
  //   weather_data_set['current_wind_speed'] =null;
  //   weather_data_set['current_wind_deg'] =null;
  //   weather_data_set['current_weather'] = null;
  //   weather_data_set['current_weather_desc'] = null;
  //   weather_data_set['current_weather_img'] = null;


    //skip the first daily forecast

    // for(int day = 1;day<8;day++) {
    //   weather_data_set['forecast_day_$day'] = {
    //     'date': null,
    //     'gen_temp':null,
    //     'min_temp': null,
    //     'max_temp': null,
    //     'temp_feel':null ,
    //     'humidity':null,
    //     'wind_speed': null,
    //     'weather':null,
    //     'weather_desc':null,
    //     'weather_img': null
    //   };
    // }

  //}
  String covert_unixtime(var unixtime)
  {
    var time = new DateTime.fromMillisecondsSinceEpoch(unixtime* 1000,isUtc:true);
    return DateFormat("dd-MM-yyyy").format(time);
  }
  String convert_img_url(var url) => 'http://openweathermap.org/img/wn/$url@2x.png';
  String convert_place(var placeName){
    var placeNameSet = placeName.split('/');
    if (placeNameSet.length>1)
      placeName = placeNameSet[1].replaceAll('_',' ');
    else
      placeName = placeNameSet[0].replaceAll('_',' ');
    return placeName;
  }
  int convert_temp(var temp) => temp.toInt();
  String convert_desctoUpperCase(var desc) => desc[0].toUpperCase()+desc.substring(1);

}




