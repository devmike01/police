import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/news/news_bloc.dart';
import 'package:police/news/news_item.dart';

import 'news_states.dart';

class NewsRoute extends StatefulWidget{

  @override
  NewsRouteState createState() {
    return NewsRouteState();
  }

}

class NewsRouteState extends State<NewsRoute>{
  @override
  Widget build(BuildContext context) {
    //context.read<NewsBloc>().fetchNews();
    return BlocBuilder<NewsBloc, NewsStates>(
      builder: (bloc, state){
        if(state is FetchNews){
          return Column(
            children: state.articles?.map((e) => NewsItem(e)).toList() ??[],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

}