import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/latlng.dart';
import 'package:police/neigbourhood/neigbourhood_event.dart';

import '../core/injector.dart';
import '../repository/police_repository.dart';
import 'neigbourhood_state.dart';

class NeigbourhoodBloc extends Bloc<NeibourhoodEvent, NeigbourhoodsState>{

  final _repo = getIt.get<PoliceRepository>();

  NeigbourhoodBloc(double? lat, double? lng): super(GetNeigbourhoodsState()){
    on<GetNeibourhoodEvent>((event, emit) async{
      emit(GetNeigbourhoodsState(isLoading: true));
      final result = await _repo.findNeigbourhood(event.latLng);
      if(result.hasError()){
        return emit(GetNeigbourhoodsState(error: result.errorMsg));
      }
      return emit(GetNeigbourhoodsState(forceNeigbourhoods: result.data));
    });
    getGetNeigbourhoods(lat, lng);
  }

  void getGetNeigbourhoods(double? lat, double? lng){
    if(lat == null)return;
    if(lng ==null)return;
    add(GetNeibourhoodEvent(LatLng(lat, lng)));
  }

}