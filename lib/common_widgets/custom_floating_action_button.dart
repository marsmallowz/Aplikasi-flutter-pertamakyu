import 'package:flutter/material.dart';

class CustomFloatButton extends StatelessWidget {
  CustomFloatButton(
      {this.onPressed, this.mini: true, this.elevation, this.child});
  final VoidCallback onPressed;
  final bool mini;
  final double elevation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      mini: mini,
      elevation: elevation,
      child: child,
    );
  }
}
