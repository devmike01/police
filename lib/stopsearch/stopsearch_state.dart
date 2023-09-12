import 'package:police/stopsearch/indexed_stopsearch.dart';

class StopSearchState{

  List<PercentStopSearch>? stopSearchList;

  String? error;

  bool isLoading;

  PercentStopSearch? topStopSearch;

  StopSearchState({this.stopSearchList, this.error, this.topStopSearch, this.isLoading=false});

  factory StopSearchState.none(){
    return StopSearchState();
  }

  StopSearchState copy({ bool? isLoading, PercentStopSearch? topStopSearch}){
    if(topStopSearch != null){
      this.topStopSearch = topStopSearch;
    }

    if(isLoading != null){
      this.isLoading = isLoading;
    }
    return this;
  }

}
