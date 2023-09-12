import 'package:flutter/cupertino.dart';
import 'package:police/forces/forces_screen.dart';
import 'package:police/home/home_screen.dart';

import '../crimes/crimes_route.dart';
import '../emergency/emergency_screen.dart';
import '../neigbourhood/neigbourhood_route.dart';
import '../news/news_detail_webview.dart';
import '../stopsearch/stopsearch_screen.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> instance = {
    HomeScreen.route : (_) => const HomeScreen(),
    ForcesScreen.route : (_) => const ForcesScreen(),
    EmergencyScreen.route : (_) => const EmergencyScreen(),
    StopSearchScreen.route : (_) => const StopSearchScreen(),
    NeigbourhoodRoute.route : (_) => const NeigbourhoodRoute(),
    NewsDetailsWebView.route : (_) => const NewsDetailsWebView()
  };
}
