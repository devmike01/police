import 'package:flutter/material.dart';
import 'package:police/crimes/crime_args.dart';
import 'package:police/crimes/crimes_route.dart';
import 'package:police/neigbourhood/neigbourhood_args.dart';
import 'package:police/news/news_details_args.dart';
import 'package:police/stopsearch/stopsearch_args.dart';

import '../emergency/emergency_screen.dart';
import '../forces/force_details_route.dart';
import '../forces/forces_screen.dart';
import '../home/home_screen.dart';
import '../neigbourhood/neigbourhood_route.dart';
import '../news/news_detail_webview.dart';
import '../settings/settings_route.dart';
import '../stopsearch/stopsearch_screen.dart';

class AppNavigator{

  final NavigatorState _navigator;

  AppNavigator(this._navigator);

  Future<T?> pushForcesRoute<T>() => _navigator.pushNamed(ForcesScreen.route);
  Future<T?> pushHomeRoute<T>() => _navigator.pushNamed(HomeScreen.route);
  Future<T?> pushEmergencyRoute<T>() => _navigator.pushNamed(EmergencyScreen.route);
  Future<T?> pushStopSearchRoute<T>(StopSearchArgs args) => _navigator
      .pushNamed(StopSearchScreen.route, arguments: args);
  Future<T?> pushNeigbourhoodRoute<T>(NeigbourhoodArgs args) => _navigator
      .pushNamed(NeigbourhoodRoute.route, arguments: args);
  Future<T?> pushCrimesRoute<T>(CrimeArgs args) => _navigator
      .pushNamed(CrimesRoute.route, arguments: args);
  Future<T?> pushNewsDetailsWebView<T>(NewsDetailsArgs args) => _navigator
      .pushNamed(NewsDetailsWebView.route, arguments: args);
  Future<T?> pushSettingsRoute<T>() => _navigator.pushNamed(SettingsRoute.route);
  Future<T?> pushForceDetailsRoute<T>(String forceId)
  => _navigator.pushNamed(ForceDetailsRoute.route, arguments: forceId);
  //CrimesRoute
  void pop<T>() => _navigator.pop();
}

extension NavigatorContext on BuildContext {
  AppNavigator get router => AppNavigator(Navigator.of(this));
}