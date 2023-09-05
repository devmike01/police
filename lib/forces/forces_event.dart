import '../models/forces.dart';

abstract class ForcesEvent{}
class GetForcesEvent extends ForcesEvent{
  String? searchText;
  GetForcesEvent({this.searchText});
}
