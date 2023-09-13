import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/repository/police_repository.dart';

import 'force_details_state.dart';

class ForceDetailCubit extends Cubit<ForceDetailState>{

  final _repo = getIt.get<PoliceRepository>();

  ForceDetailCubit(String forceId): super(ForceDetailState(isLoading: true)){
    loadForceDetails(forceId);
  }

  void loadForceDetails(String forceId) async{
    final forceDetails = await _repo.getForceDetails(forceId);
    if(forceDetails.data != null){
      emit(ForceDetailState(data: forceDetails.data));
      return;
    }
    emit(ForceDetailState(message: forceDetails.errorMsg));
  }

}