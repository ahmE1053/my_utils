import 'package:flutter/services.dart';
import 'package:my_utils/src/core/text_fields/phone_country_text_field/countries_input_formatter/egypt.dart';

import '../../string_extensions.dart';
import 'countries_input_formatter/generic.dart';

class CountryInfo {
  final String countryCode;
  final String countryName;
  final String phoneCode;
  final bool Function(String value) validator;
  final String hintText;
  final TextInputFormatter? inputFormatter;
  final String phonePrefix;

  CountryInfo({
    required this.countryCode,
    required this.countryName,
    required this.phoneCode,
    required this.validator,
    required this.hintText,
    required this.phonePrefix,
    this.inputFormatter,
  });

  factory CountryInfo.egypt() => CountryInfo(
        countryCode: 'eg',
        phoneCode: '+2',
        validator: (value) => value.isPhoneValidWithCountryCode(),
        hintText: '01XXXXXXXXX',
        phonePrefix: '+2',
        inputFormatter: EgyptianPhoneNumberFormatter(),
        countryName: 'egypt',
      );

  factory CountryInfo.saudiArabia() => CountryInfo(
        countryCode: 'sa',
        phoneCode: '+966',
        validator: (value) => value.isSaudiPhoneValidWithCountryCode(),
        hintText: '5XXXXXXXX',
        phonePrefix: '+966',
        countryName: 'saudiArabia',
      );

  factory CountryInfo.yemen() => CountryInfo(
        countryCode: 'ye',
        phoneCode: '+967',
        validator: (value) => value.isYemenPhoneWithCountryCode(),
        hintText: 'XXXXXXXXX',
        phonePrefix: '+967',
        countryName: 'yemen',
      );

  factory CountryInfo.qatar() => CountryInfo(
        countryCode: 'qa',
        phoneCode: '+974',
        validator: (value) => value.isQatarPhoneWithCountryCode(),
        hintText: 'XXXXXXXX',
        phonePrefix: '+974',
        countryName: 'qatar',
      );

  factory CountryInfo.sudan() => CountryInfo(
        countryCode: 'sd',
        phoneCode: '+249',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+249',
        inputFormatter: PhoneNumberFormatter('249'),
        countryName: 'sudan',
      );

  factory CountryInfo.rwanda() => CountryInfo(
        countryCode: 'rw',
        phoneCode: '+250',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+250',
        inputFormatter: PhoneNumberFormatter('250'),
        countryName: 'rwanda',
      );

  factory CountryInfo.ethiopia() => CountryInfo(
        countryCode: 'et',
        phoneCode: '+251',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+251',
        inputFormatter: PhoneNumberFormatter('251'),
        countryName: 'ethiopia',
      );

  factory CountryInfo.somalia() => CountryInfo(
        countryCode: 'so',
        phoneCode: '+252',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+252',
        inputFormatter: PhoneNumberFormatter('252'),
        countryName: 'somalia',
      );

  factory CountryInfo.djibouti() => CountryInfo(
        countryCode: 'dj',
        phoneCode: '+253',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+253',
        inputFormatter: PhoneNumberFormatter('253'),
        countryName: 'djibouti',
      );

  factory CountryInfo.southSudan() => CountryInfo(
        countryCode: 'ss',
        phoneCode: '+211',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+211',
        inputFormatter: PhoneNumberFormatter('211'),
        countryName: 'southSudan',
      );

  factory CountryInfo.morocco() => CountryInfo(
        countryCode: 'ma',
        phoneCode: '+212',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+212',
        inputFormatter: PhoneNumberFormatter('212'),
        countryName: 'morocco',
      );

  factory CountryInfo.algeria() => CountryInfo(
        countryCode: 'dz',
        phoneCode: '+213',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+213',
        inputFormatter: PhoneNumberFormatter('213'),
        countryName: 'algeria',
      );

  factory CountryInfo.tunisia() => CountryInfo(
        countryCode: 'tn',
        phoneCode: '+216',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+216',
        inputFormatter: PhoneNumberFormatter('216'),
        countryName: 'tunisia',
      );

  factory CountryInfo.libya() => CountryInfo(
        countryCode: 'ly',
        phoneCode: '+218',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+218',
        inputFormatter: PhoneNumberFormatter('218'),
        countryName: 'libya',
      );

  factory CountryInfo.syria() => CountryInfo(
        countryCode: 'sy',
        phoneCode: '+963',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+963',
        inputFormatter: PhoneNumberFormatter('963'),
        countryName: 'syria',
      );

  factory CountryInfo.iraq() => CountryInfo(
        countryCode: 'iq',
        phoneCode: '+964',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+964',
        inputFormatter: PhoneNumberFormatter('964'),
        countryName: 'iraq',
      );

  factory CountryInfo.kuwait() => CountryInfo(
        countryCode: 'kw',
        phoneCode: '+965',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+965',
        inputFormatter: PhoneNumberFormatter('965'),
        countryName: 'kuwait',
      );

  factory CountryInfo.oman() => CountryInfo(
        countryCode: 'om',
        phoneCode: '+968',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+968',
        inputFormatter: PhoneNumberFormatter('968'),
        countryName: 'oman',
      );

  factory CountryInfo.yemen69() => CountryInfo(
        countryCode: 'ye',
        phoneCode: '+969',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+969',
        inputFormatter: PhoneNumberFormatter('969'),
        countryName: 'yemen',
      );

  factory CountryInfo.palestine() => CountryInfo(
        countryCode: 'ps',
        phoneCode: '+970',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+970',
        inputFormatter: PhoneNumberFormatter('970'),
        countryName: 'palestine',
      );

  factory CountryInfo.uae() => CountryInfo(
        countryCode: 'ae',
        phoneCode: '+971',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+971',
        inputFormatter: PhoneNumberFormatter('971'),
        countryName: 'uae',
      );

  factory CountryInfo.bahrain() => CountryInfo(
        countryCode: 'bh',
        phoneCode: '+973',
        validator: (value) => value.isEmpty ? false : true,
        hintText: 'XXXXXXXXXX',
        phonePrefix: '+973',
        inputFormatter: PhoneNumberFormatter('973'),
        countryName: 'bahrain',
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
