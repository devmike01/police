import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:police/core/app_navigator.dart';
import 'package:police/core/latlng.dart';
import 'package:police/core/location/location_bloc.dart';
import 'package:police/core/location/location_state.dart';
import 'package:police/forces/forces_screen.dart';
import 'package:police/home/top_nav_ui.dart';
import 'package:police/misc/app_icons.dart';

import '../misc/page_title.dart';
import '../stopsearch/stopsearch_args.dart';
import 'forces_banner.dart';
import 'home_card.dart';
import 'home_content_bloc.dart';
import 'home_state.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final contentBloc = context.read<HomeContentBloc>();
    final locationBloc = context.read<LocationBloc>();

    locationBloc.getCurrentLocation();
    contentBloc.changePage(0);


    return BlocBuilder<HomeContentBloc, HomeState>(builder: (context, state) {
      String? locality;
      LatLng? latLng;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageTitle(state.title, showSettings: true,),
          TopNavBar(
            contentBloc.topBarNavItems,
            onSelect: (index) {
              contentBloc.changePage(index);
            },
          ),
          BlocBuilder<LocationBloc, LocationState>(builder: (context, locState){
            if(locState is None){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final cLocationState = locState as CurrentLocationState;

            final placemark = cLocationState.placemarks?.first;
            locality = placemark?.locality;
            latLng = cLocationState.latlng;

            return ForcesBanner(
              AppIcons.currentLocation,
              placemark?.street,
                placemark?.locality
            );
          }),
          Padding(padding: const EdgeInsets.all(20),
            child: state.homeMenus != null
                ? StaggeredGrid.count(
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
            )
                : Container(),)

        ],
      );
    });
  }

  void navigateTo(BuildContext context, String? locality, LatLng? latLng, int pos){

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
       }
      }
    }
  }
}

