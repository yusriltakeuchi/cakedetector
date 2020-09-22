
import 'package:cakedetector/ui/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterGenerator {

  /// -------------------
  /// ROUTING NAME LIST
  /// -------------------
  
  /// Home Routing
  static const routeHome = "/home";

  /// Initialize route
  static Route<dynamic> generate(RouteSettings settings) {
    /// Declaring argument route
    final args = settings.arguments;

    /// Make conditions to find correct route
    switch(settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
    }

    return null;
  }
}