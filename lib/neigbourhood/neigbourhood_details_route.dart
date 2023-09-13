import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/exts/dynamic_ext.dart';
import 'package:police/neigbourhood/neigbourhood_detail_cubit.dart';
import 'package:police/neigbourhood/neigbourhood_details_arg.dart';
import 'package:police/neigbourhood/neigbourhood_details_content.dart';

import 'neigbourhood_details_state.dart';

class NeigbourhoodDetailsRoute extends StatefulWidget{
  const NeigbourhoodDetailsRoute({super.key});

  static const String route ="/NeigbourhoodDetailsRoute";

  @override
  NeigbourhoodDetailsRouteState createState() {
    return NeigbourhoodDetailsRouteState();
  }

}

class NeigbourhoodDetailsRouteState extends State<NeigbourhoodDetailsRoute>{

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings
        .arguments.as<NeigbourhoodDetailsArg>();

    return BlocProvider(
      create: (_) => NeigbourhoodDetailsCubit(arg.neigbourhood, arg.nCode),
      child: BlocBuilder<NeigbourhoodDetailsCubit, NeigbourhoodDetailsState>(
        builder: (context, state){
          // context.read<NeigbourhoodDetailsCubit>()
          //     .loadNeigbourhoodDetails(arg.neigbourhood, arg.nCode);
          return Scaffold(
              body: SafeArea(child: state.isLoading ? const Center(
                child: CircularProgressIndicator(),
              ) : NeigbourhoodDetailsContent(state))
          );
        },
      ),);
  }

}