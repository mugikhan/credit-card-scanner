import 'package:intl/intl.dart';

extension StringX on String {
  String get monthFromExpiry => substring(0, indexOf("/"));

  String get yearFromExpiry => substring(indexOf("/") + 1, length);

  DateTime get fromDMYYtoDateTime => DateFormat("d/M/yy").parse(this);

  String get twoDigitYear => substring(2, length);
}
