enum SvgEnum {
  earth('earth'),
  ruler('ruler'),
  person('person'),
  save('save'),
  map('map'),
  settings('settings'),
  ;

  final String value;

  const SvgEnum(this.value);

  String get path => 'assets/images/icon/$value.svg';
}
