import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/forces/force_state.dart';
import 'package:police/forces/forces_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    print("object => $context");
    return Scaffold(
      appBar: AppBar(
        title: const Text("UK Police Forces"),
      ),
      body: BlocProvider(create: (_){
        return ForcesBloc();
      }, child: BlocBuilder<ForcesBloc, ForcesState>(
        builder: (BuildContext context, state) {

          final bloc = context.read<ForcesBloc>();

          if(state.isLoading){
            return const Center(child: CircularProgressIndicator(),);
          }

          return ListView.builder(
              itemCount: bloc.state.forces?.length ??0,
              itemBuilder: (context, index){
                Forces? force = bloc.state.forces?[index];
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
                      child: Image.asset(bloc.generatePoliceIcon(),
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

      ),),
    );
  }

  /*

   */

}