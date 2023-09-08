import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location/location_state.dart';

class AppPrefs {
  
  static const PREF_PLACEMARK ="AppPrefs.PREF_PLACEMARK";

  AppPrefs(){
   // clear();
  }


  Future<bool> clear()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  void setPosition(Position? position) async{
    if(position == null){
      throw Exception("AppPrefs: Placemark cannot be $position");
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_PLACEMARK, jsonEncode(position.toJson()))
    .then((value) {
      if(value){
        print("cached geo position");
      }
    })
        .catchError((error){
      print("object $error");
    });
  }

  Future<Position?> getLocationData() async{
    final prefs = await SharedPreferences.getInstance();
    final source = prefs.getString(PREF_PLACEMARK);

    if(source ==null){
      return null;
    }
    final decodedData = jsonDecode(source);
    return Position.fromMap(decodedData);
  }
  
}