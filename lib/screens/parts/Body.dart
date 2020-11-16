
import 'package:clima/services/weather_data_getter.dart';
import 'package:clima/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:clima/constants.dart';

Map weatherSet = new Map();

class Body extends State<HomeScreen> {

  void getWeatherDate() async {
    weather_data_getter data = new weather_data_getter();
    await data.get_weather_data();
    // data.weather_data_map;
   // weatherSet = data.weather_data_set;
    setState(() {
      weatherSet = data.weather_data_set as Map;
    });
  }

  @override
  void initState() {
    super.initState();
    init_map();
    getWeatherDate();

  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    //get the weather data
    getWeatherDate();
    //print(weatherSet['current_weather_img']);
    return Scaffold(
      body:Column(children: <Widget>[
      Container(
        //margin: EdgeInsets.only(bottom: defPadding * 1),
        height: size.height * 0.43,
        child: Stack(children: <Widget>[
          Container(
              padding: EdgeInsets.only(
                top:  5+defPadding,
                left: defPadding,
                right: defPadding,
              ),
              height: size.height * 0.38,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Column(children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('icons/map.png', height: 10),
                      SizedBox(width: 5),
                      Text(
                        weatherSet['current_place'].toString(),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      (weatherSet['current_weather_img']==null) ? Image.asset('icons/waitingpicture.png') :
                      Image.network(
                        weatherSet['current_weather_img'],
                        height: 40,
                      ),
                      Text(weatherSet['current_temp'].toString() + '°',
                          textAlign: TextAlign.center,
                          textScaleFactor: 5,
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(weatherSet['current_weather'].toString(),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.2,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'icons/man.png',
                        height: 13,
                      ),
                      Text(weatherSet['current_temp_feel'].toString() + '°',
                          textAlign: TextAlign.center,
                          textScaleFactor: 0.9,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(weatherSet['current_weather_desc'].toString(),
                          textAlign: TextAlign.center,
                          textScaleFactor: 0.8,
                          style: TextStyle(
                            color: Colors.white,
                          ))
                    ]),
              ])),

          //addition weather information
          Positioned(
              bottom: 00,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: defPadding),
                padding: EdgeInsets.only(
                    left: defPadding, right: defPadding, top: 15, bottom: 15),
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: primaryColor.withOpacity(0.23),
                    ),
                  ],
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(children: <Widget>[
                        Image.asset('icons/water.png', height: 18),
                        SizedBox(height: 5),
                        Text(weatherSet['current_humidity'].toString() + '%',
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: <Widget>[
                        Image.asset('icons/wind.png', height: 18),
                        SizedBox(height: 5),
                        Text(
                            weatherSet['current_wind_speed'].toString() + 'm/s',
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: <Widget>[
                        Image.asset('icons/cloud.png', height: 18),
                        SizedBox(height: 5),
                        Text(weatherSet['current_clouds'].toString() + '%',
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(children: <Widget>[
                        Image.asset('icons/sun.png', height: 18),
                        SizedBox(height: 5),
                        Text(weatherSet['current_uvi'].toString(),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold))
                      ]),
                    ),
                  ],
                ),
              )),
        ]),
      ),
      // Container(
      //     child: Stack(
      //   children: <Widget>[
      //     Positioned(
      //         bottom: 0,
      //         left: 0,
      //         right: 0,
      //         child: Container(
      //           height: 4,
      //           color: primaryColor.withOpacity(0.2),
      //         )),
      //     Text('Daily Forecast for 7 Days',
      //         textAlign: TextAlign.left,
      //         textScaleFactor: 1.15,
      //         style: TextStyle(
      //             color: Colors.black54, fontWeight: FontWeight.bold)),
      //   ],
      // )),
      Container(
          height: size.height * 0.45,
          alignment: Alignment.center,
          margin: EdgeInsets.all(defPadding),
          padding: EdgeInsets.symmetric(horizontal: defPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 10,
                color: Colors.black87.withOpacity(0.23),
              ),
            ],
          ),
          //7 Days forecast info.
          //day1
          child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[

            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(

                  padding: const EdgeInsets.only(left: 11.0),
                  child:Text(weatherSet['forecast_day_1']['date'].toString(),
                      textScaleFactor: 0.8,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black54)),
                ),

                Row(children: <Widget>[
                  (weatherSet['forecast_day_1']['weather_img']==null) ? Image.asset('icons/waitingpicture.png') :
                  Image.network(
                    weatherSet['forecast_day_1']['weather_img'],
                    height: 40,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(weatherSet['forecast_day_1']['weather'].toString(),
                            textScaleFactor: 1.2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold)),
                        Text(weatherSet['forecast_day_1']['weather_desc'].toString(),
                            textScaleFactor: 0.8,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black54)),
                      ]
                  ),
                  Spacer(),
                  Text(weatherSet['forecast_day_1']['gen_temp'].toString()+'°',
                      textScaleFactor: 2,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.bold)),
                  SizedBox(width:4),
                  Column(children: <Widget>[

                    Row(
                        children: <Widget>[
                          Image.asset('icons/up.png',
                              height:8),
                          SizedBox(width:2),
                          Text(weatherSet['forecast_day_1']['max_temp'].toString()+'°',
                              textScaleFactor: 0.8,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black54, fontWeight: FontWeight.bold)),
                        ]
                    ),
                    Row(
                        children: <Widget>[
                          Image.asset('icons/down.png',
                              height:8),
                          SizedBox(width:2),
                          Text(weatherSet['forecast_day_1']['min_temp'].toString()+'°',
                              textScaleFactor: 0.8,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black54, fontWeight: FontWeight.bold)),
                        ]
                    )


                  ]),



                ]),
              ]
            ),
                SizedBox(height:8),
                //day2
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(

                        padding: const EdgeInsets.only(left: 11.0),
                        child:Text(weatherSet['forecast_day_2']['date'].toString(),
                            textScaleFactor: 0.8,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54)),
                      ),

                      Row(children: <Widget>[
                        (weatherSet['forecast_day_2']['weather_img']==null) ? Image.asset('icons/waitingpicture.png') :
                        Image.network(
                          weatherSet['forecast_day_2']['weather_img'],
                          height: 40,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(weatherSet['forecast_day_2']['weather'].toString(),
                                  textScaleFactor: 1.2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54, fontWeight: FontWeight.bold)),
                              Text(weatherSet['forecast_day_2']['weather_desc'].toString(),
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54)),
                            ]
                        ),
                        Spacer(),
                        Text(weatherSet['forecast_day_2']['gen_temp'].toString()+'°',
                            textScaleFactor: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold)),
                        SizedBox(width:4),
                        Column(children: <Widget>[

                          Row(
                              children: <Widget>[
                                Image.asset('icons/up.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_2']['max_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Image.asset('icons/down.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_2']['min_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          )


                        ]),



                      ]),
                    ]
                ),
                SizedBox(height:8),
                //day3
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(

                        padding: const EdgeInsets.only(left: 11.0),
                        child:Text(weatherSet['forecast_day_3']['date'].toString(),
                            textScaleFactor: 0.8,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54)),
                      ),

                      Row(children: <Widget>[
                        (weatherSet['forecast_day_3']['weather_img']==null) ? Image.asset('icons/waitingpicture.png') :
                        Image.network(
                          weatherSet['forecast_day_3']['weather_img'],
                          height: 40,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(weatherSet['forecast_day_3']['weather'].toString(),
                                  textScaleFactor: 1.2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54, fontWeight: FontWeight.bold)),
                              Text(weatherSet['forecast_day_3']['weather_desc'].toString(),
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54)),
                            ]
                        ),

                        Spacer(),
                        Text(weatherSet['forecast_day_3']['gen_temp'].toString()+'°',
                            textScaleFactor: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold)),
                        SizedBox(width:4),
                        Column(children: <Widget>[

                          Row(
                              children: <Widget>[
                                Image.asset('icons/up.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_3']['max_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Image.asset('icons/down.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_3']['min_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          )


                        ]),


                      ]),
                    ]
                ),
                SizedBox(height:8),
                //day4
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(

                        padding: const EdgeInsets.only(left: 11.0),
                        child:Text(weatherSet['forecast_day_4']['date'].toString(),
                            textScaleFactor: 0.8,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54)),
                      ),

                      Row(children: <Widget>[
                        (weatherSet['forecast_day_4']['weather_img']==null) ? Image.asset('icons/waitingpicture.png') :
                        Image.network(
                          weatherSet['forecast_day_4']['weather_img'],
                          height: 40,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(weatherSet['forecast_day_4']['weather'].toString(),
                                  textScaleFactor: 1.2,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black54, fontWeight: FontWeight.bold)),
                              Text(weatherSet['forecast_day_4']['weather_desc'].toString(),
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black54)),
                            ]
                        ),

                        Spacer(),
                        Text(weatherSet['forecast_day_4']['gen_temp'].toString()+'°',
                            textScaleFactor: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold)),
                        SizedBox(width:4),
                        Column(children: <Widget>[

                          Row(
                              children: <Widget>[
                                Image.asset('icons/up.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_4']['max_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Image.asset('icons/down.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_4']['min_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          )


                        ]),


                      ]),
                    ]
                ),
                SizedBox(height:8),
                //day5
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(

                        padding: const EdgeInsets.only(left: 11.0),
                        child:Text(weatherSet['forecast_day_5']['date'].toString(),
                            textScaleFactor: 0.8,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54)),
                      ),

                      Row(children: <Widget>[
                        (weatherSet['forecast_day_5']['weather_img']==null) ? Image.asset('icons/waitingpicture.png') :
                        Image.network(
                          weatherSet['forecast_day_5']['weather_img'],
                          height: 40,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(weatherSet['forecast_day_5']['weather'].toString(),
                                  textScaleFactor: 1.2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54, fontWeight: FontWeight.bold)),
                              Text(weatherSet['forecast_day_5']['weather_desc'].toString(),
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54)),
                            ]
                        ),
                        Spacer(),
                        Text(weatherSet['forecast_day_5']['gen_temp'].toString()+'°',
                            textScaleFactor: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold)),
                        SizedBox(width:4),
                        Column(children: <Widget>[

                          Row(
                              children: <Widget>[
                                Image.asset('icons/up.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_5']['max_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Image.asset('icons/down.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_5']['min_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          )


                        ]),



                      ]),
                    ]
                ),
                SizedBox(height:8),
                //day6
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(

                        padding: const EdgeInsets.only(left: 11.0),
                        child:Text(weatherSet['forecast_day_6']['date'].toString(),
                            textScaleFactor: 0.8,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54)),
                      ),

                      Row(children: <Widget>[
                        (weatherSet['forecast_day_6']['weather_img']==null) ? Image.asset('icons/waitingpicture.png') :
                        Image.network(
                          weatherSet['forecast_day_6']['weather_img'],
                          height: 40,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(weatherSet['forecast_day_6']['weather'].toString(),
                                  textScaleFactor: 1.2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54, fontWeight: FontWeight.bold)),
                              Text(weatherSet['forecast_day_6']['weather_desc'].toString(),
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54)),
                            ]
                        ),
                        Spacer(),
                        Text(weatherSet['forecast_day_6']['gen_temp'].toString()+'°',
                            textScaleFactor: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold)),
                        SizedBox(width:4),
                        Column(children: <Widget>[

                          Row(
                              children: <Widget>[
                                Image.asset('icons/up.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_6']['max_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Image.asset('icons/down.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_6']['min_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          )


                        ]),



                      ]),
                    ]
                ),
                SizedBox(height:8),
                //day7
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(

                        padding: const EdgeInsets.only(left: 11.0),
                        child:Text(weatherSet['forecast_day_7']['date'].toString(),
                            textScaleFactor: 0.8,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54)),
                      ),

                      Row(children: <Widget>[
                        (weatherSet['forecast_day_7']['weather_img']==null) ? Image.asset('icons/waitingpicture.png') :
                        Image.network(
                          weatherSet['forecast_day_7']['weather_img'],
                          height: 40,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(weatherSet['forecast_day_7']['weather'].toString(),
                                  textScaleFactor: 1.2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54, fontWeight: FontWeight.bold)),
                              Text(weatherSet['forecast_day_7']['weather_desc'].toString(),
                                  textScaleFactor: 0.8,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black54)),
                            ]
                        ),
                        Spacer(),
                        Text(weatherSet['forecast_day_7']['gen_temp'].toString()+'°',
                            textScaleFactor: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold)),
                        SizedBox(width:4),
                        Column(children: <Widget>[

                          Row(
                              children: <Widget>[
                                Image.asset('icons/up.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_7']['max_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          ),
                          Row(
                              children: <Widget>[
                                Image.asset('icons/down.png',
                                    height:8),
                                SizedBox(width:2),
                                Text(weatherSet['forecast_day_7']['min_temp'].toString()+'°',
                                    textScaleFactor: 0.8,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black54, fontWeight: FontWeight.bold)),
                              ]
                          )


                        ]),



                      ]),
                    ]
                ),
                SizedBox(height:8),

          ]))
    ]));
  }
/*
  Future <Map> getdate()async{
    weather_data_getter data = new weather_data_getter();
    await data.get_weather_data();
    return data.weather_data_set;
  }
  */
void init_map ()  {
  weatherSet['current_place'] =null ;
  weatherSet['current_date'] =null ;
  weatherSet['current_temp'] =null;
  weatherSet['current_temp_feel'] = null;
  weatherSet['current_humidity'] = null;
  weatherSet['current_clouds'] =null ;
  weatherSet['current_uvi'] =null;
  weatherSet['current_wind_speed'] =null;
  weatherSet['current_wind_deg'] =null;
  weatherSet['current_weather'] = null;
  weatherSet['current_weather_desc'] = null;
  weatherSet['current_weather_img'] = null;



for(int day = 1;day<8;day++) {
  weatherSet['forecast_day_$day'] = {
    'date': null,
    'gen_temp':null,
    'min_temp': null,
    'max_temp': null,
    'temp_feel':null ,
    'humidity':null,
    'wind_speed': null,
    'weather':null,
    'weather_desc':null,
    'weather_img': null
  };
}

}

}
