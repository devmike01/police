import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:police/core/news_api_client.dart';
import 'package:police/core/police_api_service.dart';
import 'package:police/core/prefs.dart';
import 'package:police/core/uk_police_api.dart';

import '../location/app_geolocator.dart';
import '../repository/news_repo.dart';
import '../repository/police_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: UKPoliceApi.baseUrl))
  );


  getIt.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: UKPoliceApi.newsBaseUrl)), instanceName: UKPoliceApi.newDio
  );

  getIt.registerSingleton(AppPrefs());

  getIt.registerSingleton<PoliceApiClient>(PoliceApiClient());

  getIt.registerSingleton(PoliceRepository());

  getIt.registerSingleton(AppGeolocator());

  getIt.registerSingleton(NewsApiClient());

  getIt.registerSingleton(NewsRepository());

}
