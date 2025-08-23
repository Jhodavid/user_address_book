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
  String get list_birthdate => 'Date of birth:';

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
}
