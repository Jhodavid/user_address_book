import '../../domain/entities/user.dart';
import 'address_mapper.dart';
import 'mapper.dart';

class UserMapper extends Mapper<User> {

  final addressMapper = AddressMapper();

  @override
  User fromMap(Map<String, dynamic> map) {
    final addressMapList = (map['addresses'] as List?) ?? const [];
    final addressList = addressMapList
        .cast<Map>()
        .map((addressMap) => addressMapper.fromMap(Map<String, dynamic>.from(addressMap)))
        .toList();

    return User(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      addresses: addressList,
    );
  }

  @override
  Map<String, dynamic> toMap(User u) => {
    'id': u.id,
    'firstName': u.firstName,
    'lastName': u.lastName,
    'birthDate': u.birthDate.toIso8601String(),
    'addresses': u.addresses.map(addressMapper.toMap).toList(),
  };
}