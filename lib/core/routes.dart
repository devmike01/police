import 'package:flutter/cupertino.dart';
import 'package:police/forces/forces_screen.dart';
import 'package:police/home/home_screen.dart';

import '../emergency/emergency_screen.dart';
import '../forces/force_details_route.dart';
import '../neigbourhood/neigbourhood_route.dart';
import '../news/news_detail_webview.dart';
import '../settings/settings_route.dart';
import '../stopsearch/stopsearch_screen.dart';

class AppRoutes{
  static Map<String, Widget Function(BuildContext)> instance = {
    HomeScreen.route : (_) => const HomeScreen(),
    ForcesScreen.route : (_) => const ForcesScreen(),
    EmergencyScreen.route : (_) => const EmergencyScreen(),
    StopSearchScreen.route : (_) => const StopSearchScreen(),
    NeigbourhoodRoute.route : (_) => const NeigbourhoodRoute(),
    NewsDetailsWebView.route : (_) => const NewsDetailsWebView(),
    SettingsRoute.route : (_) => const SettingsRoute(),
    ForceDetailsRoute.route : (_) => const ForceDetailsRoute(),
  };
}
