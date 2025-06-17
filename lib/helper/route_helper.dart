import 'package:flutter/material.dart';

class RouteHelper {
  RouteHelper._();
  static RouteHelper routeHelper = RouteHelper._();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  goBack() {
    navigationKey.currentState!.pop();
  }

}
