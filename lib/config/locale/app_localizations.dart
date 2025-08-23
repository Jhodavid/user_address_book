import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'locale/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @app_name.
  ///
  /// In es, this message translates to:
  /// **'User Address Book'**
  String get app_name;

  /// No description provided for @loading.
  ///
  /// In es, this message translates to:
  /// **'Cargando...'**
  String get loading;

  /// No description provided for @list_title.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido a User Address Book!'**
  String get list_title;

  /// No description provided for @list_description.
  ///
  /// In es, this message translates to:
  /// **'Maneja tus usuarios y sus direcciones, revisa tu lista de usuarios o agrega uno nuevo.'**
  String get list_description;

  /// No description provided for @list_list_title.
  ///
  /// In es, this message translates to:
  /// **'Lista de usuarios'**
  String get list_list_title;

  /// No description provided for @list_create_button.
  ///
  /// In es, this message translates to:
  /// **'Crear usuario'**
  String get list_create_button;

  /// No description provided for @list_empty_list.
  ///
  /// In es, this message translates to:
  /// **'No hay usuarios creados.\nPresiona el botón \"Crear usuario\" para crear uno nuevo.'**
  String get list_empty_list;

  /// No description provided for @list_birthdate.
  ///
  /// In es, this message translates to:
  /// **'Fecha de nacimiento: '**
  String get list_birthdate;

  /// No description provided for @list_error_fetching_users.
  ///
  /// In es, this message translates to:
  /// **'Error al obtener los usuarios. Por favor intenta más tarde.'**
  String get list_error_fetching_users;

  /// No description provided for @address_title.
  ///
  /// In es, this message translates to:
  /// **'Nueva dirección'**
  String get address_title;

  /// No description provided for @address_line_label.
  ///
  /// In es, this message translates to:
  /// **'Dirección'**
  String get address_line_label;

  /// No description provided for @address_city_label.
  ///
  /// In es, this message translates to:
  /// **'Ciudad'**
  String get address_city_label;

  /// No description provided for @address_region_label.
  ///
  /// In es, this message translates to:
  /// **'Estado/Región (Opcional)'**
  String get address_region_label;

  /// No description provided for @address_country_label.
  ///
  /// In es, this message translates to:
  /// **'País'**
  String get address_country_label;

  /// No description provided for @address_zip_label.
  ///
  /// In es, this message translates to:
  /// **'ZIP/Código postal (Optional)'**
  String get address_zip_label;

  /// No description provided for @address_create_button.
  ///
  /// In es, this message translates to:
  /// **'Crear dirección'**
  String get address_create_button;

  /// No description provided for @address_line_error.
  ///
  /// In es, this message translates to:
  /// **'La direccción es obligatoria.'**
  String get address_line_error;

  /// No description provided for @address_city_error.
  ///
  /// In es, this message translates to:
  /// **'La ciudad es obligatoria.'**
  String get address_city_error;

  /// No description provided for @address_country_error.
  ///
  /// In es, this message translates to:
  /// **'El país es obligatorio.'**
  String get address_country_error;

  /// No description provided for @address_card_title.
  ///
  /// In es, this message translates to:
  /// **'Dirección: '**
  String get address_card_title;

  /// No description provided for @address_card_location_title.
  ///
  /// In es, this message translates to:
  /// **'Ubicación: '**
  String get address_card_location_title;

  /// No description provided for @birthdate_picker_cancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get birthdate_picker_cancel;

  /// No description provided for @birthdate_picker_done.
  ///
  /// In es, this message translates to:
  /// **'Confirmar'**
  String get birthdate_picker_done;

  /// No description provided for @form_create_user_title.
  ///
  /// In es, this message translates to:
  /// **'Crear usuario'**
  String get form_create_user_title;

  /// No description provided for @form_update_user_title.
  ///
  /// In es, this message translates to:
  /// **'Actualizar usuario'**
  String get form_update_user_title;

  /// No description provided for @form_first_name_label.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get form_first_name_label;

  /// No description provided for @form_first_name_helper.
  ///
  /// In es, this message translates to:
  /// **'Escribe tu nombre'**
  String get form_first_name_helper;

  /// No description provided for @form_last_name_label.
  ///
  /// In es, this message translates to:
  /// **'Apellido'**
  String get form_last_name_label;

  /// No description provided for @form_last_name_helper.
  ///
  /// In es, this message translates to:
  /// **'Escribe tu apellido'**
  String get form_last_name_helper;

  /// No description provided for @form_birthdate_label.
  ///
  /// In es, this message translates to:
  /// **'Fecha de nacimiento'**
  String get form_birthdate_label;

  /// No description provided for @form_birthdate_helper.
  ///
  /// In es, this message translates to:
  /// **'Selecciona tu fecha de nacimiento'**
  String get form_birthdate_helper;

  /// No description provided for @form_select_a_date.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una fecha'**
  String get form_select_a_date;

  /// No description provided for @form_addresses_title.
  ///
  /// In es, this message translates to:
  /// **'Direcciones'**
  String get form_addresses_title;

  /// No description provided for @form_add_address_button.
  ///
  /// In es, this message translates to:
  /// **'Agregar dirección'**
  String get form_add_address_button;

  /// No description provided for @form_no_addresses.
  ///
  /// In es, this message translates to:
  /// **'No hay direcciones creadas.\nPresiona el botón \"Agregar dirección\" para agregar una nueva.'**
  String get form_no_addresses;

  /// No description provided for @form_create_user_button.
  ///
  /// In es, this message translates to:
  /// **'Crear usuario'**
  String get form_create_user_button;

  /// No description provided for @form_update_user_button.
  ///
  /// In es, this message translates to:
  /// **'Actualizar usuario'**
  String get form_update_user_button;

  /// No description provided for @form_first_name_error_message.
  ///
  /// In es, this message translates to:
  /// **'Por favor ingresa un nombre válido.'**
  String get form_first_name_error_message;

  /// No description provided for @form_last_name_error_message.
  ///
  /// In es, this message translates to:
  /// **'Por favor ingresa un apellido válido.'**
  String get form_last_name_error_message;

  /// No description provided for @form_birth_date_error_message.
  ///
  /// In es, this message translates to:
  /// **'Por favor selecciona una fecha de nacimiento válida.'**
  String get form_birth_date_error_message;

  /// No description provided for @form_operation_error_title.
  ///
  /// In es, this message translates to:
  /// **'Error en la operación 😞'**
  String get form_operation_error_title;

  /// No description provided for @form_operation_error_message.
  ///
  /// In es, this message translates to:
  /// **'Ha ocurrido un error inesperado, por favor intenta nuevamente.'**
  String get form_operation_error_message;

  /// No description provided for @form_operation_error_button.
  ///
  /// In es, this message translates to:
  /// **'Entendido'**
  String get form_operation_error_button;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
