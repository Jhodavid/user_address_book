
class AddressFormState {
  final String line;
  final String city;
  final String region;
  final String country;
  final String zip;

  final String? lineError;
  final String? cityError;
  final String? countryError;

  const AddressFormState({
    this.line = '',
    this.city = '',
    this.region = '',
    this.country = '',
    this.zip = '',
    this.lineError,
    this.cityError,
    this.countryError,
  });

  factory AddressFormState.initial() => const AddressFormState();

  AddressFormState copyWith({
    String? line,
    String? city,
    String? region,
    String? country,
    String? zip,
    bool? isPrimary,
    String? lineError,
    String? cityError,
    String? countryError,
  }) {
    return AddressFormState(
      line: line ?? this.line,
      city: city ?? this.city,
      region: region ?? this.region,
      country: country ?? this.country,
      zip: zip ?? this.zip,
      lineError: lineError,
      cityError: cityError,
      countryError: countryError,
    );
  }
}
