import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/home/home_content.dart';
import 'package:police/home/home_content_bloc.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeContentBloc(),
    child:  Scaffold(
      body: HomeContent(),
      appBar: AppBar(),
    ),);
  }

}