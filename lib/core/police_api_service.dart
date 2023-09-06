import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:police/core/api_client_state.dart';
import 'package:police/core/injector.dart';

import '../models/forces.dart';
import 'core_client.dart';

class PoliceApiClient extends CoreClient{

  final dio = getIt.get<Dio>();

  Future<List<Forces>> getForces() async{
     final result = await dio.get("/forces");
     final decoded = jsonDecode(jsonEncode(result.data));
     List<Forces> forces = List.from(decoded).map((e){
       return Forces.fromJson(e);
     }).toList();
    return forces;
  }

  /*
  String data = await DefaultAssetBundle.of(context).loadString("assets/data.json");
final jsonResult = jsonDecode(data);
   */
}