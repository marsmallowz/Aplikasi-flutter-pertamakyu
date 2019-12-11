import 'package:cobaaaa_dulu/common_widgets/custom_form_submit_button.dart';
import 'package:flutter/material.dart';

class SubmitButton extends CustomInkWell {
  SubmitButton({
    VoidCallback onTap,
    String text,
    Color textColor,
    Color splColor,
  }) : super(
          onTap: onTap,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: textColor, fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        );
}
