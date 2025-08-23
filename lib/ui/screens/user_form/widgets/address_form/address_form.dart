import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_address/domain/domain.dart';
import 'package:user_address/ui/common/constants/ui_constants.dart';
import 'package:user_address/ui/screens/user_form/widgets/address_form/widgets/address_form_input.dart';

import '../../../../../config/locale/app_localizations.dart';
import 'interface/address_form_interface.dart';
import 'presenter/address_form_presenter.dart';

class AddressForm extends ConsumerStatefulWidget {
  static final lineFieldKey = Key('address-form-line_field');
  static final cityFieldKey = Key('address-form-city_field');
  static final regionFieldKey = Key('address-form-region_field');
  static final countryFieldKey = Key('address-form-country_field');
  static final zipFieldKey = Key('address-form-zip_field');
  static final submitButtonKey = Key('address-form-create_button');

  final ValueChanged<Address> onSave;

  const AddressForm({super.key, required this.onSave});

  @override
  ConsumerState createState() => _AddressFormState();
}

class _AddressFormState extends ConsumerState<AddressForm> implements AddressFormInterface {

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    final presenter = ref.read(addressFormPresenterProvider.notifier);
    final state = ref.watch(addressFormPresenterProvider);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16 + bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(locale.address_title, style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 12),
            AddressFormInput(
              fieldKey: AddressForm.lineFieldKey,
              label: locale.address_line_label,
              onChanged: presenter.onLineChanged,
              errorText: state.lineError
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: AddressFormInput(
                    fieldKey: AddressForm.cityFieldKey,
                    label: locale.address_city_label,
                    onChanged: presenter.onCityChanged,
                    errorText: state.cityError
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: state.cityError != null ? 20 : 0
                    ),
                    child: AddressFormInput(
                      fieldKey: AddressForm.regionFieldKey,
                      label: locale.address_region_label,
                      onChanged: presenter.onRegionChanged,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: AddressFormInput(
                    fieldKey: AddressForm.countryFieldKey,
                    label: locale.address_country_label,
                    onChanged: presenter.onCountryChanged,
                    errorText: state.countryError
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: state.cityError != null ? 20 : 0
                    ),
                    child: AddressFormInput(
                      fieldKey: AddressForm.zipFieldKey,
                      label: locale.address_zip_label,
                      onChanged: presenter.onZipChanged,
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.characters,
                    ),
                  )
                ),
              ],
            ),

            const SizedBox(height: 8),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                key: AddressForm.submitButtonKey,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll<Color>(UiConstants.primaryColor),
                ),
                onPressed: presenter.createAddress,
                child: Text(locale.address_create_button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = AppLocalizations.of(context);
      final presenter = ref.read(addressFormPresenterProvider.notifier);

      presenter.interface = this;
      presenter.setErrorMessages(
        lineErrorMessage: locale.address_line_error,
        cityErrorMessage: locale.address_city_error,
        countryErrorMessage: locale.address_country_error,
      );
    });
  }

  @override
  void onSave(Address address) => widget.onSave(address);
}