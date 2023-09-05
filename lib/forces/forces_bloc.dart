import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/forces/force_state.dart';
import 'package:police/forces/forces_event.dart';

import '../misc/app_icons.dart';
import '../repository/police_repository.dart';

class ForcesBloc extends Bloc<ForcesEvent, ForcesState>{

  final _repo = getIt.get<PoliceRepository>();

  ForcesBloc(): super(ForcesState.initialState){
    on<ForcesEvent>((event, emit) async{
      if(event is GetForcesEvent){
        final forces = await _repo.getForces();
        if(forces.hasData()){
          return emit(ForcesState(forces: forces.data,
              isLoading: false));
        }
        return emit(ForcesState(error: forces.errorMsg, isLoading: false));
      }

    });
    fetchForces();
  }

  void fetchForces() async{
    add(GetForcesEvent());
  }

  String generatePoliceIcon(){
    Random rand = Random();
    final randInt = rand.nextInt(AppIcons.policeIcons.length);
    return AppIcons.policeIcons[randInt];
  }

}