import 'package:flutter/material.dart';
import 'package:user_address/ui/common/constants/ui_constants.dart';

import '../../../config/locale/app_localizations.dart';

class FullScreenLoader {
  static OverlayEntry? _entry;

  static void show(BuildContext context, {String? message}) {
    if (_entry != null) return;

    final overlay = Navigator.of(context, rootNavigator: true).overlay;
    if (overlay == null) return;

    _entry = OverlayEntry(
      builder: (_) => const _LoaderOverlay(),
    );
    overlay.insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }

  static Future<T> wrap<T>(BuildContext context, Future<T> Function() task) async {
    show(context);
    try {
      return await task();
    } finally {
      hide();
    }
  }
}

class _LoaderOverlay extends StatelessWidget {
  const _LoaderOverlay();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Color(0x66000000),
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(100)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 32, width: 32,
                child: CircularProgressIndicator(strokeWidth: 4, color: UiConstants.primaryColor),
              ),
              const SizedBox(height: 16),
              Text(locale.loading, style: TextStyle(color: Colors.black87, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
