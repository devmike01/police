import 'package:police/models/forces.dart';

class ForcesState{
  List<Forces>? forces;

  String? error;

  bool isLoading;

  ForcesState({this.forces, this.error, this.isLoading =true});

  factory ForcesState.loading(){
    return ForcesState(isLoading: true);
  }

  factory ForcesState.error(String error){
    return ForcesState(error: error, isLoading: false);
  }

  factory ForcesState.success(List<Forces>? forces){
    return ForcesState(forces: forces, isLoading: false);
  }

  static get initialState => ForcesState();
}