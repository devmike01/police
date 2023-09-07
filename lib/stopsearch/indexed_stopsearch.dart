import 'package:police/models/stopsearch.dart';

class PercentStopSearch{

  double percent;
  StopSearch stopSearch;
  String? rating;
  List<StopSearch>? relatedSearches;

  PercentStopSearch(this.percent, this.stopSearch, {this.rating, this.relatedSearches});

  PercentStopSearch copy({double? percent,
    StopSearch? stopSearch, String? rating, List<StopSearch>? relatedSearches}){
    if(stopSearch != null) {
      this.stopSearch = stopSearch;
    }

    if(percent != null){
      this.percent = percent;
    }

    if(relatedSearches != null){
      this.relatedSearches = relatedSearches;
    }

    if(rating != null){
      this.rating = rating;
    }
    return this;
  }

  String percentString(){
    return "${percent.toStringAsFixed(2)}% of all the stop and search";
  }
}