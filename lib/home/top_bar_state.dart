import 'package:police/home/top_nav.dart';

class TopBarState{
  int page;
  String title;
  List<HomeMenu>? homeMenus;

  TopBarState( this.page, this.title, {this.homeMenus});

  static TopBarState nothing = TopBarState(-1, "");
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