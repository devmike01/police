import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:police/core/injector.dart';
import 'package:police/core/latlng.dart';
import 'package:police/core/uk_police_api.dart';
import 'package:police/models/crime_at_location.dart';
import 'package:police/models/force_details.dart';
import 'package:police/models/stopsearch.dart';

import '../exts/api_ext.dart';
import '../models/crime_category.dart';
import '../models/find_neigbourhood.dart';
import '../models/force_neigbourhood.dart';
import '../models/forces.dart';
import '../models/neigbourhood_details.dart';
import '../models/neigbourhood_events.dart';
import 'core_client.dart';

class PoliceApiClient extends CoreClient{

  final _dio = getIt.get<Dio>(instanceName: UKPoliceApi.policeDio);

  Future<List<Forces>> getForces() async{
     final result = await _dio.getApi("/forces");
     List<Forces> forces = List.from(result).map((e){
       return Forces.fromJson(e);
     }).toList();
    return forces;
  }

  Future<ForceDetails> getForceDetails(String forceId)async{
    final result = await _dio.getApi("/forces/$forceId");
    return ForceDetails.fromJson(result);
  }

  Future<List<StopSearch>> getStopSearchHistory(double lat, double lng,
      String date) async{
    final result = await _dio.getApi("/stops-street",
        queryParameters: {"lat": lat, "lng": lng, "date": date});
    List<StopSearch> stopSearch = List.from(result).map((e){
      return StopSearch.fromJson(e);}).toList();
     return stopSearch;
  }


  Future<FindNeigbourhood> locateNeigbourhood(LatLng latLng) async{
    final result = await _dio.getApi("/locate-neighbourhood", queryParameters: {
      'q': "${latLng.lat},${latLng.lng}",
    });


    return FindNeigbourhood.fromJson(result);
  }

  Future<List<ForceNeigbourhood>> getForceNeigbourhoods(String neigbourhood) async{
    final result = await _dio.getApi("/$neigbourhood/neighbourhoods");
    List<ForceNeigbourhood> forceNeigbourhoods = List.from(result)
        .map((e){

          final nForce = ForceNeigbourhood.fromJson(e);
          nForce.forceId = neigbourhood;
          return nForce;
    }).toList();
    return forceNeigbourhoods;
  }

  Future<NeigbourhoodDetails> getNeigbourhoodDetails(String neigbourhood, String nCode) async{
    final result = await _dio.getApi("/$neigbourhood/$nCode");
    return NeigbourhoodDetails.fromJson(result);
  }

  Future<NeigbourhoodEvents> getNeigbourhoodEvents(String neigbourhood, String nCode) async{
    final result = await _dio.getApi("/$neigbourhood/$nCode/events");
    return NeigbourhoodEvents.fromJson(result);
  }

  Future<List<CrimeCategory>> getCrimeCategories() async{
    final result = await _dio.getApi("/crime-categories");
    final categories = List.from(result)
        .map((e) => CrimeCategory.fromJson(e)).toList();
    return categories;
  }


  Future<List<CrimeAtLocation>> getCrimes(String date, double lat, double lng) async{

    final result = await _dio.getApi("/crimes-street/all-crime", queryParameters: {
      'date' : date,
      'lat': lat,
      'lng': lng
    });
    final categories = List.from(result).map((e) => CrimeAtLocation
        .fromJson(e)).toList();
    return categories;
  }



}