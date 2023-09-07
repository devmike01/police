import 'package:police/stopsearch/indexed_stopsearch.dart';

import '../models/stopsearch.dart';

abstract class StopSearchEvent{}

class FetchHistoryEvent extends StopSearchEvent{
  double lat;
  double lng;
  String dateYM;

  FetchHistoryEvent(this.lat, this.lng, this.dateYM);
}

class PredictSSStreet extends StopSearchEvent{

  List<StopSearch> stopSearchList;

  PredictSSStreet(this.stopSearchList);
}

class PredictMaxStopsEvent extends StopSearchEvent{
  PercentStopSearch percentStopSearch;
  PredictMaxStopsEvent(this.percentStopSearch);
}

