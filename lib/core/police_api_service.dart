import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:police/core/api_client_state.dart';
import 'package:police/core/injector.dart';
import 'package:police/core/latlng.dart';
import 'package:police/exts/dynamic_ext.dart';
import 'package:police/models/crime_at_location.dart';
import 'package:police/models/stopsearch.dart';

import '../models/crime_category.dart';
import '../models/find_neigbourhood.dart';
import '../models/forces.dart';
import '../models/force_neigbourhood.dart';
import '../models/neigbourhood_details.dart';
import '../models/neigbourhood_events.dart';
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

  Future<List<StopSearch>> getStopSearchHistory(double lat, double lng,
      String date) async{
    final result = await _get("/stops-street",
        queryParameters: {"lat": lat, "lng": lng, "date": date});
    List<StopSearch> stopSearch = List.from(result).map((e){
      return StopSearch.fromJson(e);}).toList();
     return stopSearch;
  }


  Future<FindNeigbourhood> locateNeigbourhood(LatLng latLng) async{
    final result = await _get("/locate-neighbourhood", queryParameters: {
      'q': "${latLng.lat},${latLng.lng}",
    });


    return FindNeigbourhood.fromJson(result);
  }

  Future<List<ForceNeigbourhood>> getForceNeigbourhoods(String neigbourhood) async{
    final result = await _get("/$neigbourhood/neighbourhoods");
    List<ForceNeigbourhood> forceNeigbourhoods = List.from(result)
        .map((e) => ForceNeigbourhood.fromJson(e)).toList();
    return forceNeigbourhoods;
  }

  Future<NeigbourhoodDetails> getNeigbourhoodDetails(String neigbourhood, String nCode) async{
    final result = await _get("/$neigbourhood/$nCode");
    return NeigbourhoodDetails.fromJson(result);
  }

  Future<NeigbourhoodEvents> getNeigbourhoodEvents(String neigbourhood, String nCode) async{
    final result = await _get("/$neigbourhood/$nCode/events");
    return NeigbourhoodEvents.fromJson(result);
  }
  
  Future<List<CrimeCategory>> getCrimeCategories() async{
    final result = await _get("/crime-categories");
    final categories = result.as<List<CrimeCategory>>();
    return categories;
  }


  Future<List<CrimeAtLocation>> getCrimes(String date, double lat, double lng) async{
    final result = await _get("/crimes-at-location", queryParameters: {
      'date' : date,
      'lat': lat,
      'lng': lng
    });
    final categories = List.from(result).map((e) => CrimeAtLocation
        .fromJson(e)).toList();
    return categories;
  }



  Future<dynamic> _get(String path, {Map<String, dynamic>? queryParameters}) async{
    final result = await dio.get(path, queryParameters: queryParameters);

    return jsonDecode(jsonEncode(result.data));
  }

}