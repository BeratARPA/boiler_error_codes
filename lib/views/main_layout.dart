import 'package:boiler_error_codes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  final Widget body;
  final CustomAppbar? appBar;

  const MainLayout({super.key, required this.body, this.appBar});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: SafeArea(child: widget.body),
    );
  }
}
