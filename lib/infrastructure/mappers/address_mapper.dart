import '../../domain/entities/address.dart';
import 'mapper.dart';

class AddressMapper extends Mapper<Address> {
  @override
  Address fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as String,
      line: map['line'] as String,
      city: map['city'] as String,
      region: map['region'] as String?,
      country: map['country'] as String,
      zip: map['zip'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap(Address a) => {
    'id': a.id,
    'line': a.line,
    'city': a.city,
    'region': a.region,
    'country': a.country,
    'zip': a.zip,
  };
}