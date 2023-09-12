import 'package:police/home/page_state.dart';

class HomeState{
  int page;
  String title;
  List<HomeMenu>? homeMenus;
  PageState pageState;

  HomeState( this.page, this.title, this.pageState, {this.homeMenus});

  static HomeState nothing = HomeState(-1, "", ForcesPage());
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