import 'package:flutter/cupertino.dart';
import 'package:police/forces/forces_screen.dart';
import 'package:police/home/home_screen.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> instance = {
    HomeScreen.route : (_) => const HomeScreen(),
    ForcesScreen.route : (_) => const ForcesScreen()
  };
}
