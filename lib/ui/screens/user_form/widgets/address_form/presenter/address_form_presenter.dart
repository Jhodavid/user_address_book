import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../domain/domain.dart';
import '../interface/address_form_interface.dart';
import '../model/address_form_state.dart';

part 'address_form_presenter.g.dart';

@riverpod
class AddressFormPresenter extends _$AddressFormPresenter {

  late final AddressFormInterface _interface;
  late final String _lineErrorMessage;
  late final String _cityErrorMessage;
  late final String _countryErrorMessage;
  
  @override
  AddressFormState build() {
    return AddressFormState.initial();
  }

  set interface(AddressFormInterface interface) {
    _interface = interface;
  }

  void setErrorMessages({
    required String lineErrorMessage,
    required String cityErrorMessage,
    required String countryErrorMessage,
  }) {
    _lineErrorMessage = lineErrorMessage;
    _cityErrorMessage = cityErrorMessage;
    _countryErrorMessage = countryErrorMessage;
  }

  void onLineChanged(String value) => state = state.copyWith(
    line: value, lineError: value.trim().isEmpty ? _lineErrorMessage : null);

  void onCityChanged(String value) => state = state.copyWith(
    city: value, cityError: value.trim().isEmpty ? _cityErrorMessage : null);

  void onRegionChanged(String value) => state = state.copyWith(region: value);

  void onCountryChanged(String value) => state = state.copyWith(
    country: value, countryError: value.trim().isEmpty ? _countryErrorMessage : null);

  void onZipChanged(String v) => state = state.copyWith(zip: v);
  
  void createAddress() {
    if(_validate()) {
      _interface.onSave(_getAddress());
    }
  }

  bool _validate() {
    final hasLine = state.line.trim().isNotEmpty;
    final hasCity = state.city.trim().isNotEmpty;
    final hasCountry = state.country.trim().isNotEmpty;

    state = state.copyWith(
      lineError: hasLine ? null : _lineErrorMessage,
      cityError: hasCity ? null : _cityErrorMessage,
      countryError: hasCountry ? null : _countryErrorMessage,
    );

    return hasLine && hasCity && hasCountry;
  }

  Address _getAddress() {
    return Address(
      id: const Uuid().v4(),
      line: state.line.trim(),
      city: state.city.trim(),
      region: state.region.trim(),
      country: state.country.trim(),
      zip: state.zip.trim().isEmpty ? '' : state.zip.trim(),
    );
  }
}