
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
  final bool isUpdating;

  UserFormState({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.birthDate,
    this.addresses = const [],
    this.firstNameError,
    this.lastNameError,
    this.birthDateError,
    this.isUpdating = false,
  });

  factory UserFormState.initial() => UserFormState();

  UserFormState copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    List<Address>? addresses,
    String? firstNameError,
    String? lastNameError,
    String? birthDateError,
    bool? isUpdating,
  }) {
    return UserFormState(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      addresses: addresses ?? this.addresses,
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      birthDateError: birthDateError,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
}
