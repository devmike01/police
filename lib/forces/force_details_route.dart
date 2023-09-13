import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/exts/dynamic_ext.dart';
import 'package:police/forces/force_detail_card.dart';
import 'package:police/forces/force_details_bloc.dart';
import 'package:police/forces/forces_bloc.dart';
import 'package:police/widgets/error_widget.dart';

import 'force_details_content.dart';
import 'force_details_state.dart';

class ForceDetailsRoute extends StatefulWidget{

  static const String notAvailable = "Not Available";
  static const String route ="/ForceDetailsRoute";


  const ForceDetailsRoute({super.key});

  @override
  ForceDetailsRouteState createState() {
    return ForceDetailsRouteState();
  }

}

class ForceDetailsRouteState extends State<ForceDetailsRoute>{

  @override
  Widget build(BuildContext context) {

    String forceId  = ModalRoute.of(context)!.settings.arguments.as<String>();

    return BlocProvider(
      create: (_) => ForceDetailCubit(forceId),
      child: BlocBuilder<ForceDetailCubit, ForceDetailState>(
        builder: (context, state){

          if(state.isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state.hasError){
            return AppErrorWidget(state.message!);
          }

          return  Scaffold(
            body: ForceDetailsContent(state),
          );
        },
      ),
    );
  }

}