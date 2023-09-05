import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/home/top_bar_state.dart';
import 'package:police/home/top_nav.dart';
import 'package:police/home/top_nav_pages_event.dart';

import '../misc/app_icons.dart';
import '../repository/police_repository.dart';

class HomeContentBloc extends Bloc<TopNavPagesEvent, TopBarState>{

  final _homeRepository = getIt.get<PoliceRepository>();

  List<TopNav> topBarNavItems = [
    TopNav(true, 0, title: "Forces"),
    TopNav(false, 1, title: "Crimes"),
    TopNav(false, 2, title: "News")
  ];

  final cardColors =[Colors.blueAccent, Colors.orange,
    Colors.purple, Colors.redAccent];

  int menuPos =-1;

  HomeContentBloc(): super(TopBarState.nothing){
    listen();
  }


  void listen(){
    on<ForcesEvent>((event, emit) => emit(TopBarState(event.getIndex(),
        event.getTitle(), homeMenus: [
          ForcesMenu("List of all forces in the Uk", AppIcons.policeman_ic, 0, Colors.redAccent.value),
          ForcesMenu("See all UK emergency numbers", AppIcons.location_ill, 1, Colors.purple.value),
          ForcesMenu("See your neigbourhood Officers", AppIcons.policeman_ic, 2, Colors.orange.value),
          ForcesMenu("Misc", AppIcons.policeman_ic, 3, Colors.blueAccent.value)
        ])));
    on<NewsEvent>((event, emit) => emit(TopBarState(event.getIndex(),
        event.getTitle())));
    on<CrimesEvent>((event, emit) => emit(TopBarState(event.getIndex(),
        event.getTitle())));
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

}