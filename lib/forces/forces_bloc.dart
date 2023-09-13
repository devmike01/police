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
        var forceList = forces.data;
        if(event.searchText != null){
          final searchedForces = forceList?.where((element) {
            return element.name.toLowerCase()
                .startsWith(event.searchText?.toLowerCase() ??'');
          }).toList();
          print("ForcesBloc ===> $searchedForces");
          return emit(ForcesState(forces: searchedForces,
              isLoading: false));
        }

        if(event.searchText ==""){
          forceList = forces.data;
        }

        if(forceList?.isNotEmpty ==true){
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