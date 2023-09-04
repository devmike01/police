import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/home/top_bar_state.dart';
import 'package:police/home/top_nav.dart';
import 'package:police/home/top_nav_pages_event.dart';

import '../misc/app_icons.dart';
import 'home_repository.dart';

class HomeContentBloc extends Bloc<TopNavPagesEvent, TopBarState>{

  final _homeRepository = getIt.get<HomeRepository>();

  List<TopNav> topBarNavItems = [
    TopNav(true, 0, title: "Forces"),
    TopNav(false, 1, title: "Crimes"),
    TopNav(false, 2, title: "News")
  ];

  int menuPos =-1;

  HomeContentBloc(): super(TopBarState.nothing){
    listen();
  }


  void listen(){
    on<ForcesEvent>((event, emit) => emit(TopBarState(event.getIndex(),
        event.getTitle(), homeMenus: [
          ForcesMenu("List of all forces in the Uk", AppIcons.policeman_ic, 0),
          ForcesMenu("See all UK emergency numbers", AppIcons.location_ill, 1),
          ForcesMenu("See your neigbourhood Officers", AppIcons.policeman_ic, 2),
          ForcesMenu("Misc", AppIcons.policeman_ic, 3)
        ])));
    on<NewsEvent>((event, emit) => emit(TopBarState(event.getIndex(),
        event.getTitle())));
    on<CrimesEvent>((event, emit) => emit(TopBarState(event.getIndex(),
        event.getTitle())));
  }

  void changePage(int index) async{
    switch(index){
      case 0 :{
        final response = await _homeRepository.getForces();
        print("object_response: $response");
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