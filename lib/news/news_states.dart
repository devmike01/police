import '../models/live_news.dart';

abstract class NewsStates{}
class None extends NewsStates{}
class FetchNews extends NewsStates{
  List<Articles>? articles;
  String? error;
  FetchNews({this.articles, this.error});
}