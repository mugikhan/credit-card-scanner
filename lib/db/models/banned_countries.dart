import 'package:isar/isar.dart';

part 'banned_countries.g.dart';

@collection
class BannedCountry {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String country;
}
