import 'package:climatify/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();

}


class _HomescreenState extends State<Homescreen> {
  double  lon;
  double lat;
  String cityname;
  var temp;
  var id;
  var weather;
  var description;
  @override
  void initState() {
    getlocation();
    getdata();
    super.initState();
  }


  void getlocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

     lon=position.longitude;
     lat=position.latitude;
     getdata();
  }

  void getdata() async{
    Response response= await get('http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=eb882977c13f658b57a1ec214cc46ab7&units=metric');
    if(response.statusCode==200){
      String data =response.body;
      var longitude1 =jsonDecode(data)['coord']['lon'];
      var latitude2 =jsonDecode(data)['coord']['lat'];
       weather =jsonDecode(data)['weather'][0]['main'];
       id =jsonDecode(data)['weather'][0]['id'];
       description =jsonDecode(data)['weather'][0]['description'];
       temp =jsonDecode(data)['main']['temp'];
       cityname =jsonDecode(data)['name'];


    }
    else {
      Text(response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima',
        textAlign: TextAlign.center),
      ),
      body: Center(
        child: Column(
          children: [
            Text(cityname.toString(),
                style: TextStyle(
                    fontSize: 50.0
                )),
            Text(temp.toString(),
                style: TextStyle(
                    fontSize: 50.0
                )),
            Text(weather.toString(),
                style: TextStyle(
                    fontSize: 50.0
                )),
            Text(description.toString(),
                style: TextStyle(
                    fontSize: 50.0
                )),
            Center(
              child: RaisedButton(child: Text('Reload'),
                onPressed: () {
                  setState(() {
                    getlocation();
                    getdata();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
