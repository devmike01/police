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

    final now = DateTime.now();
    DateTime initialDate = DateTime(now.year-2);

    return BlocProvider(
      create: (context) {
        return StopSearchBloc();
        },
    lazy: false,
    child: Scaffold(
      appBar: AppBar(
        title: const Text("Back"),
        actions: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 15),
          child: InkWell(
            onTap: (){
              showMonthYearPicker(
                context: context,
                initialDate: initialDate,
                firstDate: DateTime(now.year-2),
                lastDate: now,
              ).then((value){
                if(value != initialDate){
                  pContext?.read<StopSearchBloc>().updateTime(value);
                  pContext?.read<StopSearchBloc>()
                      .getStopAndSearch(stopSearchArgs?.lat,
                      stopSearchArgs?.lng, "${value?.year}-${value?.month}");
                }

              });
            },
            child: Row(
              children: [
                const Icon(Icons.calendar_today_outlined),
                const SizedBox(width: 10,),
                Builder(builder: (_){
                  final bloc = pContext?.read<StopSearchBloc>();
                  return StreamBuilder<DateTime>(
                    stream: bloc!.dateTime,
                    builder: (context, snapshot){
                      initialDate = snapshot.requireData;
                      return Text("${initialDate.month} - ${initialDate.year}");
                    }, initialData: initialDate,
                  );
                })
              ],
            ),
          ),)
        ],
      ),
      body: SafeArea(
        child: Builder(builder: (_){
           WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            pContext?.read<StopSearchBloc>()
                .getStopAndSearch(stopSearchArgs?.lat,
                stopSearchArgs?.lng, "${initialDate?.year}-${initialDate?.month}");
          });

          return SingleChildScrollView(
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
          );
        }),
      ),
    ),);
  }

}