import 'package:police/core/injector.dart';
import 'package:police/models/stopsearch.dart';

import '../core/api_client_state.dart';
import '../core/police_api_service.dart';
import '../core/repository.dart';
import '../models/forces.dart';

class PoliceRepository extends Repository{
  final _policeApiClient = getIt.get<PoliceApiClient>();

  Future<ApiClient<List<Forces>>> getForces(){
    return getWork(() => _policeApiClient.getForces());
  }

  Future<ApiClient<List<StopSearch>>> getStopSearches(double lat,
      double lng, String date){
    return getWork(() => _policeApiClient.getStopSearchHistory(lat, lng, date));
  }

}