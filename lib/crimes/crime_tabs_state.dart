import '../models/category_crime_by_location.dart';
import 'crime_page.dart';

abstract class CrimeTabState{}
class ChangePageState extends CrimeTabState{

  List<CategoryCrimeByLocation>? items;

  String? errorMsg;

  ChangePageState({this.items, this.errorMsg});

}
class InitialState extends CrimeTabState{}