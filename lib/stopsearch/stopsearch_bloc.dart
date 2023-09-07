import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/stopsearch/stopsearch_event.dart';
import 'package:police/stopsearch/stopsearch_state.dart';

import '../models/stopsearch.dart';
import '../repository/police_repository.dart';
import 'dart:math';
import 'indexed_stopsearch.dart';

class StopSearchBloc extends Bloc<StopSearchEvent, StopSearchState>{

  final _policeRepo = getIt.get<PoliceRepository>();
  final Map<String, PercentStopSearch> _predictor = {};

  late StopSearchState successStopSearchState;

  StopSearchBloc(): super(StopSearchState.none()){


    on<FetchHistoryEvent>((event, emit) async{
      try{

        emit(StopSearchState(isLoading: true));


        final history = await _policeRepo
            .getStopSearches(event.lat, event.lng, event.dateYM);

        successStopSearchState = StopSearchState(stopSearchList:
        predictSSStreet(history.data ??[]), isLoading: false);
        return emit(successStopSearchState);
      }catch(error){
        return emit(StopSearchState(error: error.toString(), isLoading: false));
      }

    });

    on<PredictMaxStopsEvent>((event, emit)
    => emit(successStopSearchState.copy(isLoading: false,
        topStopSearch: event.percentStopSearch)));

  }

  void getStopAndSearch(double? lat, double? lng, String dateYM){
    if(lat ==null){
      return;
    }

    if(lng ==null)return;

    add(FetchHistoryEvent(lat, lng, dateYM));
  }

  List<PercentStopSearch> predictSSStreet(List<StopSearch> stopSearchList){

    for (var stopSearch in stopSearchList) {
      final key = stopSearch.location?.street?.name;

      final predictorVal = _predictor[key];
      final related =
          predictorVal?.relatedSearches ??[];
      related.add(stopSearch);
      final value  = PercentStopSearch(predictorVal?.percent ?? 0, stopSearch);
      _predictor[key ??"-"] = value.copy(percent: value.percent + 1,
          relatedSearches: related);
    }


    // final maxValue =_predictor.values.reduce(max);
    // String crimeNeigbourhood;
    double maxSearchStops =-1;
    
    _predictor.forEach((key, value) {

      final percent = value.percent / stopSearchList.length * 100;
      
      if(maxSearchStops < percent){
        maxSearchStops = percent;
      }

      _predictor.update(key, (value) => value.copy(percent: percent,
          rating: "You're ${predict(percent)} to be searched $key."));
    });

    processMaxStops(maxSearchStops);

    return _predictor.values.toList();
  }
  
  void processMaxStops(double maxSearchStops){
    if(maxSearchStops < 0)return;
    PercentStopSearch? stopSearch;
    _predictor.forEach((key, value) {
        if(maxSearchStops == value.percent){
          stopSearch = _predictor[key];
        }
    });
    if(stopSearch != null){
      add(PredictMaxStopsEvent(stopSearch!));
    }
  }

  String predict(double percent){

    if(percent <= 20){
      return "less likely";
    }

    if(percent <= 50){
      return "likely";
    }

    if(percent <= 70){
      return "more likely";
    }

    return "most likely";
  }

}