final countries = {
  'en': {
    'egypt': 'Egypt',
    'syria': 'Syria',
    'iraq': 'Iraq',
    'kuwait': 'Kuwait',
    'saudiArabia': 'Saudi Arabia',
    'yemen': 'Yemen',
    'oman': 'Oman',
    'palestine': 'Palestine',
    'uae': 'UAE',
    'bahrain': 'Bahrain',
    'qatar': 'Qatar',
    'sudan': 'Sudan',
    'rwanda': 'Rwanda',
    'ethiopia': 'Ethiopia',
    'somalia': 'Somalia',
    'djibouti': 'Djibouti',
    'southSudan': 'South Sudan',
    'morocco': 'Morocco',
    'algeria': 'Algeria',
    'tunisia': 'Tunisia',
    'libya': 'Libya'
  },
  'ar': {
    'egypt': 'مصر',
    'syria': 'سوريا',
    'iraq': 'العراق',
    'kuwait': 'الكويت',
    'saudiArabia': 'السعودية',
    'yemen': 'اليمن',
    'oman': 'عمان',
    'palestine': 'فلسطين',
    'uae': 'الإمارات',
    'bahrain': 'البحرين',
    'qatar': 'قطر',
    'sudan': 'السودان',
    'rwanda': 'رواندا',
    'ethiopia': 'إثيوبيا',
    'somalia': 'الصومال',
    'djibouti': 'جيبوتي',
    'southSudan': 'جنوب السودان',
    'morocco': 'المغرب',
    'algeria': 'الجزائر',
    'tunisia': 'تونس',
    'libya': 'ليبيا'
  },
};

String phoneCountryNameLocalizer(String countryName, String locale) {
  return countries[locale]?[countryName] ?? countryName;
}
