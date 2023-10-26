import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/location/location_bloc.dart';
import 'package:police/home/home_content.dart';
import 'package:police/home/home_content_bloc.dart';
import 'package:police/news/news_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/uk_police_api.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  static const String route = "home.HomeScreen";

  @override
  HomeScreenState createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => HomeContentBloc()),
      BlocProvider(create: (_) => LocationBloc()),
      BlocProvider(create: (_) => NewsBloc()),
    ],
    child: HomeContent(),);
  }

}