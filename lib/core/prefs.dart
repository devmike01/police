import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/crime_category.dart';

class AppPrefs {
  
  static const PREF_PLACEMARK ="AppPrefs.PREF_PLACEMARK";
  static const PREF_CRIME_CATEGORIES =".PREF_CRIME_CATEGORIES";

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

  void setCrimeCategories(
      List<CrimeCategory>? categories) async{
    if(categories ==null){
      throw Exception("categories cannot be null");
    }
    final encode = jsonEncode(categories);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(PREF_CRIME_CATEGORIES, encode);
  }

  Future<List<CrimeCategory>?> getCrimeCategories()async{
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getString(PREF_CRIME_CATEGORIES);
    if(encoded ==null){
      return null;
    }
    final decoded = jsonDecode(encoded);
    final crimeCategories = List.from(decoded)
        .map((e) => CrimeCategory.fromJson(e)).toList();
    return crimeCategories;
  }
  
}