import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:user_address/config/providers/providers.dart';
import 'package:user_address/ui/common/constants/ui_constants.dart';
import 'package:user_address/ui/screens/user_form/presenter/user_form_presenter.dart';
import 'package:user_address/ui/screens/user_form/widgets/address_form/address_form.dart';

import '../../../config/locale/app_localizations.dart';
import '../../../domain/domain.dart';

class UserForm extends ConsumerStatefulWidget {
  static final route = '/form';

  final User? user;

  const UserForm(this.user, {super.key});

  @override
  ConsumerState createState() => _UserFormState();
}

class _UserFormState extends ConsumerState<UserForm> {

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    final presenter = ref.read(userFormPresenterProvider.notifier);
    final state = ref.watch(userFormPresenterProvider);

    Future<void> _openDatePicker() async {
      final picked = await showModalBottomSheet<DateTime>(
        context: context,
        isDismissible: true,
        showDragHandle: true,
        backgroundColor: Colors.white,
        builder: (ctx) {
          DateTime temp = DateTime.now();

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
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Cancelar'),
                        ),
                        const Spacer(),
                        FilledButton(
                          style: FilledButton.styleFrom(backgroundColor: UiConstants.primaryColor),
                          onPressed: () => Navigator.pop(ctx, temp),
                          child: const Text('Listo'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: DateTime.now(),
                      maximumDate: DateTime.now(),
                      onDateTimeChanged: (d) => temp = d,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
        presenter.onAddAddress(newAddress);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create user',
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
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text('First name', style: titleStyle),
              const SizedBox(height: 8),
              TextField(
                textCapitalization: TextCapitalization.words,
                decoration: _dec('Write your first name',error: state.firstNameError),
                onChanged: presenter.onFirstNameChanged,
              ),

              const SizedBox(height: 16),
              Text('Last name', style: titleStyle),
              const SizedBox(height: 8),
              TextField(
                textCapitalization: TextCapitalization.words,
                decoration: _dec('Write your last name' ,error: state.lastNameError),
                onChanged: presenter.onLastNameChanged,
              ),

              const SizedBox(height: 16),
              Text('Date of birth', style: titleStyle),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _openDatePicker,
                child: InputDecorator(
                  decoration: _dec('Select your birthdate', error: state.birthDateError),
                  child: Text(
                    state.birthDate == null
                      ? 'Selecciona una fecha' /// todo: move to helper with get method
                      : '${ state.birthDate!.day.toString().padLeft(2, '0')}/'
                        '${ state.birthDate!.month.toString().padLeft(2, '0')}/'
                        '${ state.birthDate!.year}',
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Addresses', style: titleStyle),
                  TextButton( /// todo: widget
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        UiConstants.onPrimaryColor)
                    ),
                    onPressed: openAddressSheet,
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: UiConstants.primaryColor,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Agregar dirección',
                          style: TextStyle(
                            color: UiConstants.primaryColor
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
              if ([].isEmpty) Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: UiConstants.onPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Sin direcciones aún'),
              )
              else Column(
                children: [].map((a) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: UiConstants.onPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Expanded(
                      child: Text(
                        '${a.line1}, ${a.city}, ${a.country}${a.zip != null ? ' (${a.zip})' : ''}',
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: UiConstants.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: presenter.createUser,
                  child: const Text('Crear Usuario'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = AppLocalizations.of(context);
      final presenter = ref.read(userFormPresenterProvider.notifier);
      final appScope = ref.read(appScopeProvider.notifier);

      presenter.appScope = ref.read(appScopeProvider);
      presenter.setErrorMessages( /// todo
        firstNameErrorMessage: locale.address_line_error,
        lastNameErrorMessage: locale.address_city_error,
        birthDateErrorMessage: locale.address_country_error,
      );
    });
  }
}

InputDecoration _dec(String helperText, {String? error}) => InputDecoration(
  filled: true,
  hintText: helperText,
  fillColor: UiConstants.onPrimaryColor,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
  errorText: error,
);
