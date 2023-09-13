import '../core/base_state.dart';
import '../models/force_details.dart';

class ForceDetailState extends BaseState<ForceDetails>{


  @override
  ForceDetails? data;

  @override
  String? message;


  @override
  bool isLoading;

  ForceDetailState({this.data, this.message, this.isLoading = false});

}