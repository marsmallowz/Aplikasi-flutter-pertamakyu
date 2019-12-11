import 'package:flutter/material.dart';

class CustomInkWell extends StatelessWidget {
  CustomInkWell(
      {this.onTap, this.child, this.borderRadius: 20.0, this.splashScreen});
  final Color splashScreen;
  final double borderRadius;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      splashColor: splashScreen,
      onTap: onTap,
      child: child,
    );
  }
}
