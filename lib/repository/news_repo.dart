import 'package:police/core/injector.dart';
import 'package:police/core/repository.dart';

import '../core/api_client_state.dart';
import '../core/news_api_client.dart';
import '../models/live_news.dart';

class NewsRepository extends Repository{
  final _newsApi = getIt.get<NewsApiClient>();

  Future<ApiClient<LiveNews>> getTopHeadlines(){
    return getWork(() => _newsApi.topHeadlines());
  }
}