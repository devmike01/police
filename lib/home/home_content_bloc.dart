import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/home/home_state.dart';
import 'package:police/home/page_state.dart';
import 'package:police/home/top_nav.dart';
import 'package:police/home/top_nav_pages_event.dart';

import '../core/auto_caller.dart';
import '../misc/app_icons.dart';
import '../misc/app_strings.dart';
import '../repository/police_repository.dart';

class HomeContentBloc extends Bloc<TopNavPagesEvent, HomeState>{

  final _homeRepository = getIt.get<PoliceRepository>();

  final _directCall = getIt.get<AutoCaller>();

  List<TopNav> topBarNavItems = [
    TopNav(true, 0, title: "Forces"),
    TopNav(false, 2, title: "Crimes"),
    TopNav(false, 1, title: "News")
  ];

  final cardColors =[Colors.blueAccent, Colors.orange,
    Colors.purple, Colors.redAccent];

  int menuPos =-1;

  HomeContentBloc(): super(HomeState.nothing){
    listen();
  }


  void listen(){
    on<ForcesEvent>((event, emit) => emit(HomeState(event.getIndex(),
        event.getTitle(), ForcesPage(), homeMenus: [
          ForcesMenu("List of all forces in the Uk", AppIcons.policeman_ic, 0, Colors.redAccent.value),
          ForcesMenu("All UK emergency numbers", AppIcons.joyfulDoctor, 1, Colors.purple.value),
          ForcesMenu(MenuStrings.stopAndSearch, AppIcons.policeCar, 2, Colors.orange.value),
          ForcesMenu(MenuStrings.neigbourhoodForce, AppIcons.policeStation, 3, Colors.blueAccent.value)
        ])));
    on<NewsEvent>((event, emit) => emit(HomeState(event.getIndex(),
        event.getTitle(), NewsPage())));
    on<CrimesEvent>((event, emit) => emit(HomeState(event.getIndex(),
        event.getTitle(), CrimePage())));
  }

  void changePage(int index) async{
    switch(index){
      case 0 :{
        add(ForcesEvent());
      }
      case 1:{
        add(NewsEvent());
      }
      case 2:{
        add(CrimesEvent());
      }
    }
  }

  void placeEmergencyCall(){
    _directCall.emergencyCall();
  }

}