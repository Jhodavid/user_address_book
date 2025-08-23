// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'User Address Book';

  @override
  String get loading => 'Loading...';

  @override
  String get list_title => 'Welcome to User Address Book!';

  @override
  String get list_description => 'Manage your users and their addresses, review your user list, or add a new one.';

  @override
  String get list_list_title => 'User List';

  @override
  String get list_create_button => 'Create user';

  @override
  String get list_empty_list => 'There are no users created.\nClick the \"Create user\" button to create a new one.';

  @override
  String get list_birthdate => 'Date of birth: ';

  @override
  String get address_title => 'New Address';

  @override
  String get address_line_label => 'Address line';

  @override
  String get address_city_label => 'City';

  @override
  String get address_region_label => 'State/Region (Optional)';

  @override
  String get address_country_label => 'Country';

  @override
  String get address_zip_label => 'ZIP/Postal code (Optional)';

  @override
  String get address_create_button => 'Create address';

  @override
  String get address_line_error => 'Address line is required.';

  @override
  String get address_city_error => 'City is required.';

  @override
  String get address_country_error => 'Country is required.';

  @override
  String get address_card_title => 'Address: ';

  @override
  String get address_card_location_title => 'Location: ';

  @override
  String get birthdate_picker_cancel => 'Cancel';

  @override
  String get birthdate_picker_done => 'Done';

  @override
  String get form_create_user_tittle => 'Crear usuario';

  @override
  String get form_update_user_title => 'Update user';

  @override
  String get form_first_name_label => 'First name';

  @override
  String get form_first_name_helper => 'Write your first name';

  @override
  String get form_last_name_label => 'Last name';

  @override
  String get form_last_name_helper => 'Write your last name';

  @override
  String get form_birthdate_label => 'Date of birth';

  @override
  String get form_birthdate_helper => 'Select your birthdate';

  @override
  String get form_select_a_date => 'Select a date';

  @override
  String get form_addresses_title => 'Addresses';

  @override
  String get form_add_address_button => 'Add address';

  @override
  String get form_no_addresses => 'No addresses created.\nPress the \"Add address\" button to add a new one.';

  @override
  String get form_create_user_button => 'Create user';

  @override
  String get form_update_user_button => 'Update user';

  @override
  String get form_first_name_error_message => 'Please enter a valid first name.';

  @override
  String get form_last_name_error_message => 'Please enter a valid last name.';

  @override
  String get form_birth_date_error_message => 'Please select a valid birthdate.';

  @override
  String get form_operation_error_title => 'Operation error 😞';

  @override
  String get form_operation_error_message => 'An unexpected error occurred, please try again.';

  @override
  String get form_operation_error_button => 'Understood';
}
