import 'package:police/core/injector.dart';
import 'package:police/core/prefs.dart';
import 'package:police/models/crime_at_location.dart';
import 'package:police/models/crime_category.dart';
import 'package:police/models/force_neigbourhood.dart';
import 'package:police/models/stopsearch.dart';

import '../core/api_client_state.dart';
import '../core/latlng.dart';
import '../core/police_api_service.dart';
import '../core/repository.dart';
import '../models/category_crime_by_location.dart';
import '../models/find_neigbourhood.dart';
import '../models/forces.dart';
import '../models/neigbourhood_details.dart';

class PoliceRepository extends Repository{
  final _policeApiClient = getIt.get<PoliceApiClient>();
  final _prefs = getIt.get<AppPrefs>();

  Future<ApiClient<List<Forces>>> getForces(){
    return getWork(() => _policeApiClient.getForces());
  }

  Future<ApiClient<List<StopSearch>>> getStopSearches(double lat,
      double lng, String date){
    return getWork(() => _policeApiClient.getStopSearchHistory(lat, lng, date));
  }

  Future<ApiClient<List<ForceNeigbourhood>>> getFindNeigbourhood(String neigbourhood){
    return getWork(() => _policeApiClient.getForceNeigbourhoods(neigbourhood));
  }

  Future<ApiClient<List<ForceNeigbourhood>>> findNeigbourhood(LatLng latLng) async{
    final foundNeigbourhood = await getWork(() => _policeApiClient
        .locateNeigbourhood(latLng));

    final result = foundNeigbourhood.data?.force;

    if(result != null){
      final forceNeigbourhoods = await getWork(() => _policeApiClient
          .getForceNeigbourhoods(result));
      return forceNeigbourhoods;
    }

    return ApiClient(errorMsg: foundNeigbourhood.errorMsg);
  }

  Future<ApiClient<List<CrimeAtLocation>>> crimeAtLocationByCategory(String categoryId,
      String date, double lat, double lng){
    return getWork(() async{
      final crimes = await _policeApiClient.getCrimes(date, lat, lng);
      return crimes.where((crime) => crime.category == categoryId).toList();
    });

  }

  Future<ApiClient<List<CrimeAtLocation>>> crimeAtLocation(
      String date, double lat, double lng){
    return getWork(() => _policeApiClient.getCrimes(date, lat, lng));
  }

  Future<ApiClient<List<CrimeCategory>>> crimeCategories() async{
    final result = await getWork(() => _policeApiClient.getCrimeCategories());
    _prefs.setCrimeCategories(result.data);
    return result;
  }

}