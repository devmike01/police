import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/exts/dynamic_ext.dart';
import 'package:police/neigbourhood/neigbourhood_bloc.dart';
import 'package:police/widgets/column_tile.dart';

import '../misc/app_icons.dart';
import '../misc/app_strings.dart';
import '../misc/page_title.dart';
import '../widgets/error_widget.dart';
import 'neigbourhood_args.dart';
import 'neigbourhood_state.dart';

class NeigbourhoodRoute extends StatefulWidget{

  static String route = "neigbourhood_route/NeigbourhoodRoute";

  const NeigbourhoodRoute({super.key});

  @override
  NeigbourhoodRouteState createState() {
    return NeigbourhoodRouteState();
  }

}

class NeigbourhoodRouteState extends State<NeigbourhoodRoute>{

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings!
        .arguments.as<NeigbourhoodArgs>();

    return BlocProvider(create: (_) => NeigbourhoodBloc(args.lat, args.lng),
    child: Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
      ),
      body:  SafeArea(
        child: Builder(builder: (context){
          return SingleChildScrollView(
            child: Column(
              children: [
                PageTitle(MenuStrings.neigbourhoodForce),
                BlocBuilder<NeigbourhoodBloc,
                    NeigbourhoodsState>(builder: (context, state){

                  final neigbourState = state.as<GetNeigbourhoodsState>();

                  if(neigbourState.isLoading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if(neigbourState.error != null){
                    return AppErrorWidget(neigbourState.error ??"" );
                  }

                  final neigbourForces = neigbourState.forceNeigbourhoods;
                  return Column(
                    children: [
                      Column(
                        children: neigbourForces?.map((e) => ColumnTile(e.name,
                            args.locality, AppIcons.currentLocation)).toList() ?? [],
                      )
                    ],
                  );
                })
              ],
            ),
          ) ;
        }),
      ),
    ),);
  }

}