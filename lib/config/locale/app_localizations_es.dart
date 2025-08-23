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
  String get loading => 'Cargando...';

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
  String get list_birthdate => 'Fecha de nacimiento: ';

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

  @override
  String get address_card_title => 'Dirección: ';

  @override
  String get address_card_location_title => 'Ubicación: ';

  @override
  String get birthdate_picker_cancel => 'Cancelar';

  @override
  String get birthdate_picker_done => 'Confirmar';

  @override
  String get form_create_user_tittle => 'Crear usuario';

  @override
  String get form_update_user_title => 'Actualizar usuario';

  @override
  String get form_first_name_label => 'Nombre';

  @override
  String get form_first_name_helper => 'Escribe tu nombre';

  @override
  String get form_last_name_label => 'Apellido';

  @override
  String get form_last_name_helper => 'Escribe tu apellido';

  @override
  String get form_birthdate_label => 'Fecha de nacimiento';

  @override
  String get form_birthdate_helper => 'Selecciona tu fecha de nacimiento';

  @override
  String get form_select_a_date => 'Selecciona una fecha';

  @override
  String get form_addresses_title => 'Direcciones';

  @override
  String get form_add_address_button => 'Agregar dirección';

  @override
  String get form_no_addresses => 'No hay direcciones creadas.\nPresiona el botón \"Agregar dirección\" para agregar una nueva.';

  @override
  String get form_create_user_button => 'Crear usuario';

  @override
  String get form_update_user_button => 'Actualizar usuario';

  @override
  String get form_first_name_error_message => 'Por favor ingresa un nombre válido.';

  @override
  String get form_last_name_error_message => 'Por favor ingresa un apellido válido.';

  @override
  String get form_birth_date_error_message => 'Por favor selecciona una fecha de nacimiento válida.';

  @override
  String get form_operation_error_title => 'Error en la operación 😞';

  @override
  String get form_operation_error_message => 'Ha ocurrido un error inesperado, por favor intenta nuevamente.';

  @override
  String get form_operation_error_button => 'Entendido';
}
