import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/crime_category.dart';

class AppPrefs {
  
  static const PREF_PLACEMARK ="AppPrefs.PREF_PLACEMARK";
  static const PREF_CRIME_CATEGORIES =".PREF_CRIME_CATEGORIES";
  static const PREF_NOTIFICATION_CRIME =".PREF_NOTIFICATION_CRIME";
  static const PREF_NOTIFICATION_NEWS =".PREF_NOTIFICATION_NEWS";
  static const PREF_OLD_NOTIF = ".PREF_OLD_NOTIF";


  AppPrefs();

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

  Future<bool> setOldNews(int oldNewsTime) async{
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(PREF_OLD_NOTIF, oldNewsTime);
  }

  Future<int> getOldNewsTime() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(PREF_OLD_NOTIF) ?? -1;
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

  void setEnableCrimeNotif(bool enabled) async{
    final pref = await SharedPreferences.getInstance();
    pref.setBool(PREF_NOTIFICATION_CRIME, enabled);
  }

  void setEnableNewsNotif(bool enabled) async{
    final pref = await SharedPreferences.getInstance();
    pref.setBool(PREF_NOTIFICATION_NEWS, enabled);
  }


  Future<bool> enableNewsNotif() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(PREF_NOTIFICATION_NEWS) ?? false;
  }

  Future<bool> enableCrimeNotif() async{
    final pref = await SharedPreferences.getInstance();
    return pref.getBool(PREF_NOTIFICATION_CRIME) ?? false;
  }

  Future<bool> clear()async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }


}