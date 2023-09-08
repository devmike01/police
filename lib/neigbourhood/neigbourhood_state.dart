import '../models/force_neigbourhood.dart';

abstract class NeigbourhoodsState{}

class GetNeigbourhoodsState extends NeigbourhoodsState{
  List<ForceNeigbourhood>? forceNeigbourhoods;
  String? error;
  bool isLoading;
  GetNeigbourhoodsState({this.forceNeigbourhoods, this.error, this.isLoading=false});
}
class RecentEventState extends NeigbourhoodsState{}