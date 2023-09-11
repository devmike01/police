import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/crimes/crime_tab_cubit.dart';
import 'package:police/crimes/crime_tabs_state.dart';
import 'package:police/crimes/crimes_bloc.dart';
import 'package:police/exts/dynamic_ext.dart';
import 'package:police/widgets/error_widget.dart';

import 'crime_args.dart';
import 'crime_page.dart';

class CrimesTabs extends StatelessWidget{

  String? locality;

  CrimesTabs(this.locality, {super.key});

  @override
  Widget build(BuildContext context) {


  return SizedBox(
   // height: 500,
    child: BlocBuilder<CrimeTabCubit, CrimeTabState>(
      builder: (context, state){

        if(state is InitialState){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        ChangePageState? crimeState = state.as<ChangePageState>();

        if(crimeState.errorMsg != null){
          return AppErrorWidget(crimeState.errorMsg ?? "");
        }

        return
          SingleChildScrollView(
            child: DefaultTabController(
            length: crimeState.items?.length ??0,
            child: SizedBox(
              // height: double.maxFinite,
              child: Column(
                children: [
                  // Expanded(child:
                  TabBar(
                    isScrollable :true,
                    onTap: (pos){
                      final key = crimeState.items?[pos].category;
                      context.read<CrimeTabCubit>().loadNewData(pos, key);
                    },
                    tabs: crimeState.items?.map((e) =>
                        Tab(child: Text( e.category),)).toList() ??[],
                  ),
                  Column(
                    // clipBehavior: Clip.,
                      children: crimeState.items?.map((e)
                      => CrimePage(e.crimes)).toList() ?? [])
                ],
              ),
            ),
          ),);
      },
    ),
  );
  }

}
/*
return DefaultTabController(
          length: crimeState.items?.length ??0,
          child:
          SizedBox(
          //  height: double.maxFinite,
            child: Column(
              children: [Text("ld;lskds;k;dl")],
            ),
          )
       );

DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (pos){

            },
            tabs: items.map((tab) => Tab(text: tab.title,)).toList(),
          ),
          title: const Text('Tabs Demo'),
        ),
        body:  TabBarView(
          children: items.children,
        ),
      ),
    )
 */