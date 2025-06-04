import 'package:calculator/app/core/constant/settings.dart';

enum EndpointsEnum {
  deflectionGpt('deflection'),
  ;

  final String value;

  const EndpointsEnum(this.value);

  String get testLocalhost => '${Settings.localhost}/$value';

 // String get gptEndpoints => '${Settings.}';
}
