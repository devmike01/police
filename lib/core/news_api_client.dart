import 'package:dio/dio.dart';
import 'package:police/core/injector.dart';
import 'package:police/core/uk_police_api.dart';

import '../exts/api_ext.dart';
import '../models/live_news.dart';

class NewsApiClient{

  final _dio = getIt.get<Dio>(instanceName: UKPoliceApi.newDio);

  Future<LiveNews> topHeadlines() async{
    //UKPoliceApi
    final liveNewsObj = await _dio.getApi("/top-headlines", queryParameters: {
      'country': 'gb', 'apiKey': 'fc9253147e8d4573bab560418b41a239'
    });

    return LiveNews.fromJson(liveNewsObj);
  }

}