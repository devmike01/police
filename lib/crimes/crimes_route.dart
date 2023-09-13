import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'crime_args.dart';
import 'crime_tab_cubit.dart';
import 'crime_tabs.dart';

class CrimesRoute extends StatelessWidget{

  static String route ="crimes/CrimePage";
  CrimeArgs crimeArgs;

  CrimesRoute(this.crimeArgs, {super.key});


  @override
  Widget build(BuildContext context) {

    final dateTime = DateTime.now();


    return BlocProvider(
        create: (_) => CrimeTabCubit("${dateTime.year}-${dateTime.month < 2 ? dateTime.month : 1}",
            crimeArgs.lat ??0, crimeArgs.lng ??0),
        child: CrimesTabs(crimeArgs.locality)
    );
  }

}