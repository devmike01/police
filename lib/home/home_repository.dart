import 'package:police/core/injector.dart';

import '../core/api_client_state.dart';
import '../core/police_api_service.dart';
import '../core/repository.dart';
import '../models/forces.dart';

class HomeRepository extends Repository{
  final _policeApiClient = getIt.get<PoliceApiClient>();

  Future<ApiClient<List<Forces>>> getForces(){
    return getWork(() => _policeApiClient.getForces());
  }

}