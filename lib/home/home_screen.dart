import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/location/location_bloc.dart';
import 'package:police/home/home_content.dart';
import 'package:police/home/home_content_bloc.dart';
import 'package:police/news/news_bloc.dart';

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
    child:  const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: HomeContent(),
            ),
          )),
    ),);
  }

}