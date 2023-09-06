import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/emergency_nums.dart';

class AssetManager{

  static Future<List<EmergencyNum>> getEmergencyNumbers(BuildContext context) async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/emergency_numbers.json");
    final jsonResult = jsonDecode(data);
    List<dynamic> objects = jsonResult.toList();
    final emergencyList = objects.map((
        e) => EmergencyNum.fromJson(e)).toList();
    return emergencyList;
  }
}