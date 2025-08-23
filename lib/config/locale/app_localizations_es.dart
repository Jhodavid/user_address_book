// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get app_name => 'User Address Book';

  @override
  String get list_title => 'Bienvenido a User Address Book!';

  @override
  String get list_description => 'Maneja tus usuarios y sus direcciones, revisa tu lista de usuarios o agrega uno nuevo.';

  @override
  String get list_list_title => 'Lista de usuarios';

  @override
  String get list_create_button => 'Crear usuario';

  @override
  String get list_empty_list => 'No hay usuarios creados.\nPresiona el botón \"Crear usuario\" para crear uno nuevo.';

  @override
  String get list_birthdate => 'Fecha de nacimiento:';

  @override
  String get address_title => 'Nueva dirección';

  @override
  String get address_line_label => 'Dirección';

  @override
  String get address_city_label => 'Ciudad';

  @override
  String get address_region_label => 'Estado/Región (Opcional)';

  @override
  String get address_country_label => 'País';

  @override
  String get address_zip_label => 'ZIP/Código postal (Optional)';

  @override
  String get address_create_button => 'Crear dirección';

  @override
  String get address_line_error => 'La direccción es obligatoria.';

  @override
  String get address_city_error => 'La ciudad es obligatoria.';

  @override
  String get address_country_error => 'El país es obligatorio.';
}
