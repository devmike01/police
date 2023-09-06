import 'package:flutter/cupertino.dart';
import 'package:police/core/injector.dart';
import 'package:police/emergency/emergency_screen.dart';
import 'package:police/forces/forces_screen.dart';
import 'package:police/home/home_screen.dart';

class AppNavigator{

  final NavigatorState _navigator;

  AppNavigator(this._navigator);

  Future<T?> pushForcesRoute<T>() => _navigator.pushNamed(ForcesScreen.route);
  Future<T?> pushHomeRoute<T>() => _navigator.pushNamed(HomeScreen.route);
  Future<T?> pushEmergencyRoute<T>() => _navigator.pushNamed(EmergencyScreen.route);
  void pop<T>() => _navigator.pop();
}

extension NavigatorContext on BuildContext {
  AppNavigator get router => AppNavigator(Navigator.of(this));
}