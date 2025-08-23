
import 'package:user_address/domain/domain.dart';

class UserFormState {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final List<Address> addresses;

  final String? firstNameError;
  final String? lastNameError;
  final String? birthDateError;

  UserFormState({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.birthDate,
    this.addresses = const [],
    this.firstNameError,
    this.lastNameError,
    this.birthDateError,
  });

  factory UserFormState.initial() => UserFormState();

  UserFormState copyWith({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    List<Address>? addresses,
    String? firstNameError,
    String? lastNameError,
    String? birthDateError,
  }) {
    return UserFormState(
      id: id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      addresses: addresses ?? this.addresses,
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      birthDateError: birthDateError,
    );
  }
}
