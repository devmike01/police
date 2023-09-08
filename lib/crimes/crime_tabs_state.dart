import 'crime_page.dart';

abstract class CrimeTabState{}
class ChangePageState extends CrimeTabState{
  List<CrimePage> items;

  ChangePageState(this.items);

}
class InitialState extends CrimeTabState{}