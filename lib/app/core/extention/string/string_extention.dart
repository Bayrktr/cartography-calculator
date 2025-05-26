import 'package:calculator/app/core/extention/string/datetime_extention.dart';
import 'package:calculator/app/core/extention/string/lang_extention.dart';

extension StringExtension on String {
  LangExtension get lang => LangExtension(this);

  DatetimeExtention get datetime => DatetimeExtention(this);
}
