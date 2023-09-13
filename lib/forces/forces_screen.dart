import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/app_navigator.dart';
import 'package:police/exts/buildcontext_ext.dart';
import 'package:police/forces/force_state.dart';
import 'package:police/forces/forces_bloc.dart';
import 'package:police/forces/search_bloc.dart';
import 'package:police/forces/search_state.dart';
import 'package:police/misc/page_title.dart';

import '../widgets/column_tile.dart';

class ForcesScreen extends StatefulWidget{

  static const String route = "forces.ForcesScreen";

  const ForcesScreen({super.key});

  @override
  ForcesScreenState createState() {
    return ForcesScreenState();
  }


}

class ForcesScreenState extends State<ForcesScreen>{

  final TextEditingController _searchController = TextEditingController();

  @override // const Text("UK Police Forces")
  Widget build(BuildContext context) {
    SearchBloc? searchBloc;
    ForcesBloc? forcesBloc;


    List<Widget> children = [Padding(padding: const EdgeInsets.all(10),
      child: PageTitle("Police forces in the\nUnited Kingdom", showSettings: false,),)];

    return MultiBlocProvider(
    providers: [
        BlocProvider(create: (_){
      return SearchBloc();
    }),   BlocProvider(create: (_){
        return ForcesBloc();
      })
    ],
    child: Scaffold(
      appBar:  AppBar(
        leading:  InkWell(
          onTap: (){
            if(searchBloc?.fieldShow ==true){
              searchBloc?.hideField();
              forcesBloc?.fetchForces();
              return;
            }
            context.router.pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state){
            searchBloc = BlocProvider.of<SearchBloc>(context);
            return state.showField ?  TextField(
              controller: _searchController,
              onChanged: (value){
               //searchBloc?.searchText(value);
                context.read<ForcesBloc>()
                    .fetchForces(searchText: value);
              },
              decoration: const InputDecoration(
                  hintText: "Search police force"
              ),
            ): const Text("Back");
          },
        ),
        actions:  [
          Padding(padding: const EdgeInsets.only(right: 20),
            child: BlocProvider(create: (_){
              return SearchBloc();
            }, child: InkWell(
              child: const Icon(Icons.search),
              onTap: (){
                searchBloc?.showField();
              },
            ),))
        ],
      ),
      body: BlocBuilder<ForcesBloc, ForcesState>(
        builder: (BuildContext context, state) {

          forcesBloc = context.read<ForcesBloc>();

          if(state.isLoading){
            return const Center(child: CircularProgressIndicator(),);
          }

          if(state.error != null){
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              context.showSnackbar(Text("${state.error}"));
            });
          }

          children.add(Column(
            children: forcesBloc?.state.forces?.map((force) {
              return ColumnTile(
                  force.name,
                  force.country,
                  forcesBloc?.generatePoliceIcon(),
                onTap: (){
                    context.router.pushForceDetailsRoute(force.id);
                },
              );
            }).toList() ?? [],
          ));

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          );
        },

      ),
    ));
  }

  /*

   */

}