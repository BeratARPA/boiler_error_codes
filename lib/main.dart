import 'package:boiler_error_codes/helpers/app_navigator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppNavigator.routes,
      initialRoute: "/home",
    );
  }
}
