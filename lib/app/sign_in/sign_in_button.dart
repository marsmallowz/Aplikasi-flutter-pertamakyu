import 'package:cobaaaa_dulu/common_widgets/custom_floating_action_button.dart';
import 'package:flutter/material.dart';

class SignInButton extends CustomFloatButton {
  SignInButton({
    VoidCallback onPressed,
    double elevation,
    String text,
  }) : super(
            onPressed: onPressed,
            elevation: elevation,
            child: Image(
              image: AssetImage(text),
            ));
}
