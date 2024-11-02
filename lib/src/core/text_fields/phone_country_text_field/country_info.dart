import '../../string_extensions.dart';

class CountryInfo {
  final String countryCode;
  final String phoneCode;
  final bool Function(String value) validator;
  final String hintText;
  final String phonePrefix;

  CountryInfo({
    required this.countryCode,
    required this.phoneCode,
    required this.validator,
    required this.hintText,
    required this.phonePrefix,
  });

  factory CountryInfo.egypt() => CountryInfo(
        countryCode: 'eg',
        phoneCode: '+2',
        validator: (value) => value.isPhoneValidWithCountryCode(),
        hintText: '01XXXXXXXXX',
        phonePrefix: '+2',
      );

  factory CountryInfo.saudiArabia() => CountryInfo(
        countryCode: 'sa',
        phoneCode: '+966',
        validator: (value) => value.isSaudiPhoneValidWithCountryCode(),
        hintText: '5XXXXXXXX',
        phonePrefix: '+966',
      );

  factory CountryInfo.yemen() => CountryInfo(
        countryCode: 'ye',
        phoneCode: '+967',
        validator: (value) => value.isYemenPhoneWithCountryCode(),
        hintText: 'XXXXXXXXX',
        phonePrefix: '+967',
      );

  factory CountryInfo.qatar() => CountryInfo(
        countryCode: 'qa',
        phoneCode: '+974',
        validator: (value) => value.isQatarPhoneWithCountryCode(),
        hintText: 'XXXXXXXX',
        phonePrefix: '+974',
      );

  static var _phoneNumbersList = <CountryInfo>[
    CountryInfo.egypt(),
    CountryInfo.saudiArabia(),
    CountryInfo.qatar(),
    CountryInfo.yemen(),
  ];

  static set phoneNumbersList(List<CountryInfo> list) {
    assert(
      list.isNotEmpty,
      "Country list cannot be empty",
    );
    _phoneNumbersList = list;
  }

  static List<CountryInfo> get getPhoneCountries => _phoneNumbersList;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryInfo && countryCode == other.countryCode;

  @override
  int get hashCode => countryCode.hashCode;
}
