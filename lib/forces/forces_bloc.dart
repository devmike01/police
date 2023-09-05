import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/forces/force_state.dart';
import 'package:police/forces/forces_event.dart';

import '../misc/app_icons.dart';
import '../models/forces.dart';
import '../repository/police_repository.dart';

class ForcesBloc extends Bloc<ForcesEvent, ForcesState>{

  final _repo = getIt.get<PoliceRepository>();

  ForcesBloc(): super(ForcesState.initialState){
    on<ForcesEvent>((event, emit) async{
      if(event is GetForcesEvent){
        final forces = await _repo.getForces();
        var forceList = forces.data;
        if(event.searchText != null){
          forceList = forceList?.where((element) => 
          element.name.toLowerCase().contains(event.searchText?.toLowerCase() ??'')).toList();
        }

        if(event.searchText ==""){
          forceList = forces.data;
        }
        if(forces.hasData()){
          return emit(ForcesState(forces: forceList,
              isLoading: false));
        }
        return emit(ForcesState(error: forces.errorMsg, isLoading: false));
      }

    });
    fetchForces();
  }

  void fetchForces({String? searchText}) async{
    add(GetForcesEvent(searchText: searchText));
  }

  String generatePoliceIcon(){
    Random rand = Random();
    final randInt = rand.nextInt(AppIcons.policeIcons.length);
    return AppIcons.policeIcons[randInt];
  }

}