import 'package:police/core/base_state.dart';
import 'package:police/models/neigbourhood_details.dart';

class NeigbourhoodDetailsState extends BaseState<NeigbourhoodDetails>{

  String? openMapMsg;

  NeigbourhoodDetailsState({this.data, this.message,
    this.isLoading =false, this.openMapMsg});

  @override
  NeigbourhoodDetails? data;

  @override
  bool isLoading;

  @override
  String? message;
}