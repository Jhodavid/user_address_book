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
}