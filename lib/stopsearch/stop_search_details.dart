import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:police/models/stopsearch.dart';
import 'package:police/stopsearch/stopsearch_bloc.dart';
import 'package:police/stopsearch/stopsearch_detail_item.dart';

import 'indexed_stopsearch.dart';

class StopSearchRoute extends StatefulWidget{

  StopSearch? stopSearch;

  StopSearchRoute({super.key, this.stopSearch});

  @override
  StopSearchRouteState createState() {
    return StopSearchRouteState();
  }

  static void show(StopSearch? stopSearch, BuildContext context){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StopSearchRoute(stopSearch: stopSearch,);
      },
    );
  }

}

class StopSearchRouteState extends State<StopSearchRoute>{

  @override
  Widget build(BuildContext context) {
    final search = widget.stopSearch;
    return SingleChildScrollView(
      child:  Padding(padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(search?.type ?? StopSearchBloc.na,
            style: Theme.of(context).textTheme.titleLarge,),
          Text(search?.legislation ?? StopSearchBloc.na,
            style: Theme.of(context).textTheme.titleSmall,),
          const SizedBox(height: 20,),
          StopSearchDetailItem(icon: Icons.location_on_outlined,
            title: search?.location?.street?.name ?? StopSearchBloc.na,),
          StopSearchDetailItem(icon: Icons.accessibility,
            title: search?.outcome ?? StopSearchBloc.na,),
          StopSearchDetailItem(icon: Icons.account_circle_outlined,
            title: search?.gender ?? StopSearchBloc.na,),
          StopSearchDetailItem(icon: Icons.account_tree_outlined,
            title: search?.operationName ?? StopSearchBloc.na,),
          StopSearchDetailItem(icon: Icons.account_circle_outlined,
            title: search?.officerDefinedEthnicity ?? StopSearchBloc.na,),
          StopSearchDetailItem(icon: Icons.add_chart_outlined,
            title: search?.ageRange ?? StopSearchBloc.na,),
          StopSearchDetailItem(icon: Icons.account_box,
            title: search?.selfDefinedEthnicity ?? StopSearchBloc.na,)
        ],
      ),),
    );
  }

}