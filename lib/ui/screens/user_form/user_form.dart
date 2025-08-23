import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/locale/app_localizations.dart';
import '../../../config/providers/providers.dart';
import '../../../domain/domain.dart';
import '../../common/constants/ui_constants.dart';
import '../../common/helpers/ui_helpers.dart';
import '../../common/widgets/add_text_button.dart';
import '../../common/widgets/full_screen_loader.dart';
import 'interface/user_form_interface.dart';
import 'presenter/user_form_presenter.dart';
import 'widgets/address_data_card.dart';
import 'widgets/address_form/address_form.dart';
import 'widgets/birthdate_picker.dart';

class UserForm extends ConsumerStatefulWidget {
  static final firstNameFieldKey = Key('user-form-first_name_field');
  static final lastNameFieldKey = Key('user-form-last_name_field');
  static final birthDateFieldKey = Key('user-form-birth_date_field');
  static final addAddressButtonKey = Key('user-form-add_address_button');
  static final submitButtonKey = Key('user-form-submit_button');

  static final route = '/form';

  final User? user;

  const UserForm(this.user, {super.key});

  @override
  ConsumerState createState() => _UserFormState();
}

class _UserFormState extends ConsumerState<UserForm> implements UserFormInterface {

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    final presenter = ref.read(userFormPresenterProvider.notifier);
    final state = ref.watch(userFormPresenterProvider);

    Future<void> openDatePicker() async {
      final picked = await showModalBottomSheet<DateTime>(
        context: context,
        isDismissible: true,
        showDragHandle: true,
        backgroundColor: Colors.white,
        builder: (context) => BirthdatePicker(
          state.birthDate,
          onSelectedBirthdate: (date) => Navigator.of(context).pop(date),
        ),
      );

      if (picked != null) {
        presenter.onSelectBirthDate(picked);
      }
    }

    Future<void> openAddressSheet() async {
      final newAddress = await showModalBottomSheet<Address>(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        showDragHandle: true,
        backgroundColor: Colors.white,
        builder: (ctx) => AddressForm(
          onSave: (Address address) {
            Navigator.of(ctx).pop(address);
          },
        ),
      );

      if (newAddress != null) {
        presenter.onCreateAddress(newAddress);
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            state.isUpdating
              ? locale.form_update_user_title : locale.form_create_user_title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (_, constraints) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locale.form_first_name_label, style: titleStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        key: UserForm.firstNameFieldKey,
                        initialValue: widget.user?.firstName,
                        textCapitalization: TextCapitalization.words,
                        decoration: _dec(
                          locale.form_first_name_helper,
                          error: state.firstNameError
                        ),
                        onChanged: presenter.onFirstNameChanged,
                      ),

                      const SizedBox(height: 12),
                      Text(locale.form_last_name_label, style: titleStyle),
                      const SizedBox(height: 8),
                      TextFormField(
                        key: UserForm.lastNameFieldKey,
                        initialValue: widget.user?.lastName,
                        textCapitalization: TextCapitalization.words,
                        decoration: _dec(locale.form_last_name_helper ,error: state.lastNameError),
                        onChanged: presenter.onLastNameChanged,
                      ),

                      const SizedBox(height: 12),
                      Text(locale.form_birthdate_label, style: titleStyle),
                      const SizedBox(height: 8),
                      GestureDetector(
                        key: UserForm.birthDateFieldKey,
                        onTap: openDatePicker,
                        child: InputDecorator(
                          decoration: _dec(locale.form_birthdate_helper, error: state.birthDateError),
                          child: Text(
                            state.birthDate == null
                              ? locale.form_select_a_date
                              : UiHelpers.getBirthDateText(state.birthDate!),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(locale.form_addresses_title, style: titleStyle),
                          AddTextButton(
                            key: UserForm.addAddressButtonKey,
                            icon: Icons.add,
                            label: locale.form_add_address_button,
                            onPressed: openAddressSheet
                          )
                        ],
                      ),

                      if(state.addresses.isEmpty) Center(
                        child: Text(
                          locale.form_no_addresses,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ),

                      SizedBox(
                        height: constraints.maxHeight * 0.22,
                        child: ListView.builder(
                          itemCount: state.addresses.length,
                          itemBuilder: (context, index) {
                            final address = state.addresses[index];

                            return AddressDataCard(
                              address, onDelete: () => presenter.onRemoveAddress(address),
                            );
                          },
                        )
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: FilledButton(
                          key: UserForm.submitButtonKey,
                          style: FilledButton.styleFrom(
                            backgroundColor: UiConstants.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: presenter.onSubmit,
                          child: Text(
                            state.isUpdating
                              ? locale.form_update_user_button
                              : locale.form_create_user_button
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = AppLocalizations.of(context);
      final presenter = ref.watch(userFormPresenterProvider.notifier);

      presenter.interface = this;
      presenter.appScope = ref.read(appScopeProvider);
      presenter.setErrorMessages(
        firstNameErrorMessage: locale.form_first_name_error_message,
        lastNameErrorMessage: locale.form_last_name_error_message,
        birthDateErrorMessage: locale.form_birth_date_error_message,
      );

      if(widget.user != null) {
        presenter.loadUserData(widget.user!);
      }
    });
  }

  @override
  void showLoading() => FullScreenLoader.show(context);

  @override
  void hideLoading() => FullScreenLoader.hide();

  @override
  void showError() => UiHelpers.showErrorDialog(
    context,
    title: AppLocalizations.of(context).form_operation_error_title,
    message: AppLocalizations.of(context).form_operation_error_message,
    buttonText: AppLocalizations.of(context).form_operation_error_button,
  );

  @override
  void onContinue() => Navigator.of(context).pop();
}

InputDecoration _dec(String helperText, {String? error}) => InputDecoration(
  filled: true,
  hintText: helperText,
  fillColor: UiConstants.onPrimaryColor,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
  errorText: error,
);
