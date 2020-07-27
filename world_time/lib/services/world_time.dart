import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{

  String location;  //location name for UnderlineInputBorder
  String time;      // the time in that location
  String flag; // url to an asset flag icon
  String url;  // this is the location url for api endpoint
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async{

    try {
      Response response= await get('http://worldtimeapi.org/api/timezone/$url');
      JsonDecoder decoder = new JsonDecoder();
      Map data= decoder.convert(response.body);
      //print(data);

      //get properties from data
      String datatime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      //create DataTime object

      DateTime now = DateTime.parse(datatime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time
      isDayTime = now.hour> 6 && now.hour < 20 ? true : false;
      time= DateFormat.jm().format(now);
    } catch (e) {
      print(e);
      time = 'could not get time data';
    }

  }

}


