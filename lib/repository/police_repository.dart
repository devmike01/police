import 'package:police/core/injector.dart';
import 'package:police/models/force_neigbourhood.dart';
import 'package:police/models/stopsearch.dart';

import '../core/api_client_state.dart';
import '../core/latlng.dart';
import '../core/police_api_service.dart';
import '../core/repository.dart';
import '../models/find_neigbourhood.dart';
import '../models/forces.dart';
import '../models/neigbourhood_details.dart';

class PoliceRepository extends Repository{
  final _policeApiClient = getIt.get<PoliceApiClient>();

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

}