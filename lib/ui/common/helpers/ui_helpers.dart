
import 'package:flutter/material.dart';

import '../constants/ui_constants.dart';

class UiHelpers {

  static String getBirthDateText(DateTime birthDate) {
    return '${birthDate.day.toString().padLeft(2, '0')}/'
           '${birthDate.month.toString().padLeft(2, '0')}/'
           '${birthDate.year}';
  }

  static Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String buttonText,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: UiConstants.onPrimaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: UiConstants.primaryColor),
              const SizedBox(width: 8),
              Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
            ],
          ),
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
          ),
          actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          actions: [
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: UiConstants.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(buttonText),
              ),
            ),
          ],
        );
      },
    );
  }
}