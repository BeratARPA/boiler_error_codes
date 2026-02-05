import 'package:boiler_error_codes/views/home_view.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/home": (context) => const HomeView(),
  };
}
