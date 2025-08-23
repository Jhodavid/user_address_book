class Address {
  final String id;
  final String line;
  final String city;
  final String region;
  final String country;
  final String zip;

  const Address({
    required this.id,
    required this.line,
    required this.city,
    this.region = '',
    required this.country,
    this.zip = '',
  });

  Address copyWith({
    String? line,
    String? city,
    String? region,
    String? country,
    String? zip,
  }) => Address(
    id: id,
    line: line ?? this.line,
    city: city ?? this.city,
    region: region ?? this.region,
    country: country ?? this.country,
    zip: zip ?? this.zip,
  );
}