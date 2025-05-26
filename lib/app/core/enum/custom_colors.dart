import 'package:flutter/material.dart';

enum CustomColors {
  white('ffffff'),
  bodySmall('CCC78F'),
  iconBackground('4A4521'),
  bottombarBackground('333317'),
  scaffoldBackground('24210F'),
  ;

  final String value;

  const CustomColors(this.value);

  int get toRgba => int.parse('0xFF$value');

  Color get getColor => Color(toRgba);
}
