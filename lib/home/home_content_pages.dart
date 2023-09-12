import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:police/core/app_navigator.dart';
import 'package:police/crimes/crime_args.dart';
import 'package:police/crimes/crimes_route.dart';
import 'package:police/exts/buildcontext_ext.dart';
import 'package:police/home/page_state.dart';

import '../core/latlng.dart';
import '../forces/forces_screen.dart';
import '../neigbourhood/neigbourhood_args.dart';
import '../news/news_route.dart';
import '../stopsearch/stopsearch_args.dart';
import 'home_card.dart';
import 'home_content_bloc.dart';
import 'home_state.dart';

class HomeContentPages extends StatelessWidget{
  HomeState state;
  String? locality;
  LatLng? latLng;
  HomeContentBloc contentBloc;

  HomeContentPages(this.state, this.latLng,
      this.locality,
      this.contentBloc, {super.key}){

    print("object_011 ==> ${latLng?.lat}");
  }

  @override
  Widget build(BuildContext context) {
    final pageState = state.pageState;
    if(pageState is ForcesPage){
      return StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
        children: state.homeMenus?.map((e) {
          contentBloc.menuPos += 1;
          final homeMenu = (e as ForcesMenu);
          return StaggeredGridTile.extent(
              crossAxisCellCount: 1,
              mainAxisExtent: contentBloc.menuPos % 2 > 0 ? 190 : 230,
              child: Card(
                color: Color(homeMenu.color),
                margin: EdgeInsets.zero,
                child: HomeCard(
                  index: homeMenu.index,
                  title: homeMenu.title,
                  image: homeMenu.imgResPath,
                  onTap: (index){

                    navigateTo(context, locality, latLng, index);
                  },),
              ));
        }).toList() ?? [],
      );
    }

    if(pageState is CrimePage){
      return CrimesRoute(CrimeArgs(locality, latLng?.lat, latLng?.lng));
    }
    return NewsRoute();
  }

  void navigateTo(BuildContext context, String? locality,
      LatLng? latLng, int pos){

    switch(pos){
      case 0:{
        Navigator.pushNamed(context, ForcesScreen.route);
      }
      case 1: {
        context.router.pushEmergencyRoute();
      }
      case 2:{
        if(latLng != null){
          context.router.pushStopSearchRoute(StopSearchArgs(
              locality,  latLng?.lat, latLng?.lng
          ));
        }else{
          context.showSnackbar(const
          Text("You need to enable location to use this feature."));
        }
      }
      case 3:{
        context.router.pushNeigbourhoodRoute(NeigbourhoodArgs(locality,
            latLng?.lat, latLng?.lng));
      }
    }
  }

}