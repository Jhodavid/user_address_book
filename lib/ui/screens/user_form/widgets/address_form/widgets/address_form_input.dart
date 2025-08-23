
import 'package:flutter/material.dart';

import '../../../../../common/constants/ui_constants.dart';

class AddressFormInput extends StatelessWidget {

  final Key fieldKey;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final String label;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const AddressFormInput({
    super.key,
    required this.fieldKey,
    this.textCapitalization = TextCapitalization.words,
    this.keyboardType = TextInputType.text,
    required this.label,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: fieldKey,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      decoration: _dec(label , error: errorText),
      onChanged: onChanged,
    );
  }
}

InputDecoration _dec(String label, {String? error}) => InputDecoration(
  labelText: label,
  labelStyle: TextStyle(color: Colors.black),
  filled: true,
  fillColor: UiConstants.onPrimaryColor,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
  errorText: error,
);