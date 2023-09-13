import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/neigbourhood/neigbourhood_details_state.dart';
import 'package:police/repository/map_repo.dart';

import '../repository/police_repository.dart';

class NeigbourhoodDetailsCubit extends Cubit<NeigbourhoodDetailsState>{

  String neigbourhood;
  String nCode;

  final _repo = getIt.get<PoliceRepository>();
  final _mapRepo = getIt.get<MapRepo>();

  NeigbourhoodDetailsCubit(this.neigbourhood, this.nCode): super(NeigbourhoodDetailsState()){
    loadNeigbourhoodDetails();
  }

  void loadNeigbourhoodDetails() async{
    emit(NeigbourhoodDetailsState(isLoading: true));
    final neigbourhoodDetails = await _repo.neigbourhoodDetails(neigbourhood, nCode);
    print("object_1error ==> ${neigbourhoodDetails.errorMsg}");
    if(neigbourhoodDetails.data != null){
      emit(NeigbourhoodDetailsState(data: neigbourhoodDetails.data));
    }else{
      emit(NeigbourhoodDetailsState(message: neigbourhoodDetails.errorMsg));
    }
  }

  void openMap(String? address) async{
    final result = await _mapRepo.openMap(address);
    if(result.hasError()){
      emit(NeigbourhoodDetailsState(data: state.data,
          openMapMsg: result.errorMsg));
    }
  }

}