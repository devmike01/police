import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/app_navigator.dart';
import 'package:police/core/injector.dart';
import 'package:police/forces/force_state.dart';
import 'package:police/forces/forces_bloc.dart';
import 'package:police/forces/search_bloc.dart';
import 'package:police/forces/search_state.dart';
import 'package:police/models/forces.dart';

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
            ): const Text("UK Police Forces");
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

          return ListView.builder(
              itemCount: forcesBloc?.state.forces?.length ??0,
              itemBuilder: (context, index){
                Forces? force = forcesBloc?.state.forces?[index];
                return Padding(padding: const EdgeInsets.only(left: 10,
                    right: 10, bottom: 7, top: 7), child: Row(
                    children:[
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: const BorderRadius.all(Radius.circular(40)),
                            border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          child: Image.asset(forcesBloc?.generatePoliceIcon() ??"",
                            width: 40, height: 40, fit: BoxFit.cover,),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(force?.name ??"",
                            style: Theme.of(context).textTheme.titleSmall,),
                          Text(force?.country ??"",
                            style: Theme.of(context)
                                .textTheme.bodySmall
                                ?.copyWith(color: Colors.black45),)
                        ],
                      )
                    ]
                ),);
              });
        },

      ),
    ));
  }

  /*

   */

}