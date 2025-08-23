
import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';

class AddTextButton extends StatelessWidget {

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const AddTextButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(
          UiConstants.onPrimaryColor)
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
            color: UiConstants.primaryColor,
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: UiConstants.primaryColor
            ),
          ),
        ],
      )
    );
  }
}
