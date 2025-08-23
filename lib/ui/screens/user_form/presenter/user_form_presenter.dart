import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../domain/domain.dart';
import '../../../../config/providers/models/app_scope.dart';
import '../interface/user_form_interface.dart';
import '../model/user_form_state.dart';

part 'user_form_presenter.g.dart';

@riverpod
class UserFormPresenter extends _$UserFormPresenter {

  late final UserFormInterface _interface;
  late final AppScope _appScope;

  late final String _firstNameErrorMessage;
  late final String _lastNameErrorMessage;
  late final String _birthDateErrorMessage;

  @override
  UserFormState build() {
    return UserFormState.initial();
  }

  set interface(UserFormInterface interface) {
    _interface = interface;
  }
  set appScope(AppScope useCases) {
    _appScope = useCases;
  }

  void setErrorMessages({
    required String firstNameErrorMessage,
    required String lastNameErrorMessage,
    required String birthDateErrorMessage,
  }) {
    _firstNameErrorMessage = firstNameErrorMessage;
    _lastNameErrorMessage = lastNameErrorMessage;
    _birthDateErrorMessage = birthDateErrorMessage;
  }

  void loadUserData(User user) {
    state = state.copyWith(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      birthDate: user.birthDate,
      addresses: user.addresses,
      isUpdating: true,
    );
  }

  void onFirstNameChanged(String value) => state = state.copyWith(
    firstName: value, firstNameError: value.trim().isEmpty ? _firstNameErrorMessage : null);

  void onLastNameChanged(String value) => state = state.copyWith(
    lastName: value, lastNameError: value.trim().isEmpty ? _lastNameErrorMessage : null);

  void onSelectBirthDate(DateTime? value) => state = state.copyWith(
    birthDate: value, birthDateError: value == null ? _birthDateErrorMessage : null);

  void onCreateAddress(Address address) => state = state.copyWith(addresses: [...state.addresses, address]);

  void onRemoveAddress(Address address) => state = state.copyWith(
    addresses: state.addresses.where((a) => a.id != address.id).toList()
  );

  void onSubmit() {
    if(state.isUpdating) {
      _updateUser();
    } else {
      _createUser();
    }
  }

  Future<void> _createUser() async {
    if(!_validate()) return;
    _interface.showLoading();

    final user = _getUser();
    final (error, _) = await _appScope.createUser(user);
    _interface.hideLoading();

    if(error != null) {
      _interface.showError();
      return;
    }

    _interface.onContinue();
  }

  Future<void> _updateUser() async {
    if(!_validate()) return;
    _interface.showLoading();

    final user = _getUser();
    final (error, _) = await _appScope.updateUser(user);
    _interface.hideLoading();

    if(error != null) {
      _interface.showError();
      return;
    }

    _interface.onContinue();
  }

  bool _validate() {
    final hasFirstName = state.firstName.trim().isNotEmpty;
    final hasLastName = state.lastName.trim().isNotEmpty;
    final hasBirthDate = state.birthDate != null;

    state = state.copyWith(
      firstNameError: hasFirstName ? null : _firstNameErrorMessage,
      lastNameError: hasLastName ? null : _lastNameErrorMessage,
      birthDateError: hasBirthDate ? null : _birthDateErrorMessage,
    );

    return hasFirstName && hasLastName && hasBirthDate;
  }

  User _getUser() {
    return User(
      id: state.isUpdating ? state.id : const Uuid().v4(),
      firstName: state.firstName.trim(),
      lastName: state.lastName.trim(),
      birthDate: state.birthDate!,
      addresses: state.addresses,
    );
  }
}