import 'address.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final List<Address> addresses;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.addresses = const [],
  });

  factory User.empty() => User(
    id: '',
    firstName: '',
    lastName: '',
    birthDate: DateTime.now(),
  );

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    List<Address>? addresses,
  }) => User(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    birthDate: birthDate ?? this.birthDate,
    addresses: addresses ?? this.addresses,
  );
}