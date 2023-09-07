import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:police/home/forces_banner.dart';
import 'package:police/misc/app_icons.dart';
import 'package:police/misc/page_title.dart';
import 'package:police/stopsearch/stopsearch_args.dart';
import 'package:police/stopsearch/stopsearch_bloc.dart';
import 'package:police/stopsearch/stopsearch_state.dart';
import 'package:police/widgets/column_tile.dart';
import 'package:police/widgets/error_widget.dart';

import '../misc/app_strings.dart';


class StopSearchScreen extends StatefulWidget{

  const StopSearchScreen({super.key});

  static const route ="stopsearch/StopSearchScreen";

  @override
  StopSearchScreenState createState() {
    return  StopSearchScreenState();
  }

}

class StopSearchScreenState extends State<StopSearchScreen>{

  @override
  Widget build(BuildContext context) {

    StopSearchArgs stopSearchArgs = ModalRoute.of(context)!
        .settings.arguments as StopSearchArgs;

    BuildContext? pContext;

    return BlocProvider(
      create: (context) {
        return StopSearchBloc();
        },
    lazy: false,
    child: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
        final now = DateTime.now();

        showMonthYearPicker(
          context: context,
          initialDate: DateTime(now.year-2),
          firstDate: DateTime(now.year-2),
          lastDate: now,
        ).then((value){
          pContext?.read<StopSearchBloc>()
              .getStopAndSearch(stopSearchArgs?.lat,
              stopSearchArgs?.lng, "${value?.year}-${value?.month}");
        });
      }, icon: const Icon(Icons.date_range_outlined),
      label: const Text("Change date"),),
      appBar: AppBar(
        title: const Text("Back"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<StopSearchBloc, StopSearchState>(
            builder: (context, state){

              pContext = context;
              if(state.error != null){
                return AppErrorWidget(state.error ??"");
              }

              if(state.isLoading){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }


              final topStopSearch = state.topStopSearch;
              return Column(
                children: [
                  PageTitle(MenuStrings.stopAndSearch),
                  ForcesBanner(
                      AppIcons.policeType1,
                      "${topStopSearch?.stopSearch.location?.street?.name
                          ??"N/A"} in ${stopSearchArgs.locality}",
                      topStopSearch?.percentString()
                  ),
                  const SizedBox(height: 20,),
                  Padding(padding: const EdgeInsets.all(0),
                    child: Column(
                      children: state.stopSearchList?.map((e)
                      => ColumnTile(e?.stopSearch.location?.street?.name,
                          e.rating, AppIcons.location_ill, onTap: (){

                        },)).toList() ??[],
                    ), )
                ],
              );
            },
          ),
        ),
      ),
    ),);
  }

}