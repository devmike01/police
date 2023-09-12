import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/news/news_states.dart';
import 'package:police/repository/news_repo.dart';

import '../core/injector.dart';

class NewsBloc extends Cubit<NewsStates>{

  final _repo = getIt.get<NewsRepository>();

  NewsBloc(): super(None()){
    fetchNews();
  }


  void fetchNews() async{
    final headlines = await _repo.getTopHeadlines();
    if(headlines.data != null){
      final articles = headlines.data?.articles;
      if(articles != null){
        emit(FetchNews(articles: articles));
      }
    }else{
      emit(FetchNews(error: headlines.errorMsg));
    }
  }

}