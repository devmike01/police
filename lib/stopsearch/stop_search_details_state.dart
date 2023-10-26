import 'package:police/core/base_state.dart';

import 'indexed_stopsearch.dart';

class StopSearchDetailsState extends BaseState<PercentStopSearch>{
  @override
  PercentStopSearch? data;

  @override
  bool isLoading;

  @override
  String? message;

  StopSearchDetailsState({this.data, this.message, this.isLoading=false});

}