import 'package:police/models/crime_at_location.dart';

import '../models/category_crime_by_location.dart';

abstract class CrimeTabState{}
class ChangePageState extends CrimeTabState{

  List<String>? categories;
  List<CrimeAtLocation>? crimes;

  //TODO: To be removed
  List<CategoryCrimeByLocation>? items;

  String? errorMsg;

  ChangePageState({this.items, this.categories, this.crimes, this.errorMsg});

}
class InitialState extends CrimeTabState{}