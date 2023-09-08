import 'package:flutter/material.dart';
import 'package:police/neigbourhood/neigbourhood_args.dart';
import 'package:police/stopsearch/stopsearch_args.dart';
import '../emergency/emergency_screen.dart';
import '../forces/forces_screen.dart';
import '../home/home_screen.dart';
import '../neigbourhood/neigbourhood_route.dart';
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
  void pop<T>() => _navigator.pop();
}

extension NavigatorContext on BuildContext {
  AppNavigator get router => AppNavigator(Navigator.of(this));
}