import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/app_navigator.dart';
import 'package:police/core/latlng.dart';
import 'package:police/core/location/location_bloc.dart';
import 'package:police/core/location/location_state.dart';
import 'package:police/home/top_nav_ui.dart';
import 'package:police/misc/app_icons.dart';

import '../core/workers/notification_worker.dart';
import '../misc/page_title.dart';
import 'forces_banner.dart';
import 'home_content_bloc.dart';
import 'home_content_pages.dart';
import 'home_state.dart';

class HomeContent extends StatelessWidget {
   const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final contentBloc = context.read<HomeContentBloc>();
    final locationBloc = context.read<LocationBloc>();

    locationBloc.getCurrentLocation();
    contentBloc.changePage(0);

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) {
      initWorker();
    });

    return BlocBuilder<HomeContentBloc, HomeState>(builder: (context, state) {
      String? locality;
      LatLng? latLng;
      return   Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(onPressed: (){
              context.read<HomeContentBloc>().placeEmergencyCall();
            }, child: Icon(Icons.emergency_outlined),)
          ],
        ),
        body:  SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: SizedBox(
                  //height: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PageTitle(state.title, showSettings: true,
                          onSettingsClicked: (){
                            context.router.pushSettingsRoute();
                          }),
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

                        // Change banner content
                        return Column(
                          children: [
                            ForcesBanner(
                                AppIcons.currentLocation,
                                placemark?.street,
                                placemark?.locality
                            ),
                            Padding(padding: const EdgeInsets.all(20),
                                child: HomeContentPages(state, latLng, locality, contentBloc))
                          ],
                        );
                      }),

                    ],
                  ),
                ),
              ),
            )),
      ) ;
    });
  }
}

