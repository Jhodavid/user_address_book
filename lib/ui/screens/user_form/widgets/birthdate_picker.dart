import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_address/config/locale/app_localizations.dart';

import '../../../common/constants/ui_constants.dart';

class BirthdatePicker extends StatelessWidget {
  static final cancelButtonKey = Key('birthdate-picker-cancel_button');
  static final doneButtonKey = Key('birthdate-picker-done_button');

  final DateTime? initialDate;
  final ValueChanged<DateTime> onSelectedBirthdate;

  const BirthdatePicker(
    this.initialDate, {
    super.key, required this.onSelectedBirthdate
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    DateTime currentSelected = initialDate ?? DateTime.now();

    return SafeArea(
      child: SizedBox(
        height: 320,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  TextButton(
                    key: cancelButtonKey,
                    onPressed: () => Navigator.pop(context),
                    child: Text(locale.birthdate_picker_cancel),
                  ),
                  const Spacer(),
                  FilledButton(
                    key: doneButtonKey,
                    style: FilledButton.styleFrom(backgroundColor: UiConstants.primaryColor),
                    onPressed: () => onSelectedBirthdate(currentSelected),
                    child: Text(locale.birthdate_picker_done),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: currentSelected,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (dateTime) => currentSelected = dateTime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
