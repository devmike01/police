import 'package:police/home/top_nav.dart';

class HomeState{
  int page;
  String title;
  List<HomeMenu>? homeMenus;

  HomeState( this.page, this.title, {this.homeMenus});

  static HomeState nothing = HomeState(-1, "");
}

class ForcesMenu extends HomeMenu{
  String title;
  String imgResPath;
  int index;
  int color;

  ForcesMenu(this.title, this.imgResPath, this.index, this.color);
}


abstract class HomeMenu{}
class NoHomeMenu extends HomeMenu{
  static NoHomeMenu instance = NoHomeMenu();
}