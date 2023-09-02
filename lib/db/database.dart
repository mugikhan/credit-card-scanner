import 'package:flutter_card_scanner/countries/select_banned_countries.dart';
import 'package:flutter_card_scanner/db/models/banned_countries.dart';
import 'package:flutter_card_scanner/db/models/credit_card.dart';
import 'package:flutter_card_scanner/models/exceptions.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  //Singleton access acroos the app
  static final DatabaseManager _instance = DatabaseManager._internal();

  late Isar isar;

  factory DatabaseManager() {
    return _instance;
  }

  DatabaseManager._internal();

  Future<void> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [CreditCardSchema, BannedCountrySchema],
      directory: dir.path,
    );
  }

  Future<void> saveCardDetails(CreditCard creditCard) async {
    try {
      CreditCard? currentCard =
          isar.creditCards.getByCardNumberSync(creditCard.cardNumber);
      if (currentCard?.id != null || currentCard?.cardNumber != null) {
        throw ItemExistsException("Item already exists");
      }
      await isar.writeTxn(() async {
        await isar.creditCards.put(creditCard);
      });
    } catch (_) {
      rethrow;
    }
  }

  Future<void> addBannedCountry(SelectCountry selectCountry) async {
    try {
      await isar.writeTxn(() async {
        BannedCountry bannedCountry = BannedCountry()
          ..country = selectCountry.country
          ..selected = selectCountry.selected;
        await isar.bannedCountrys.put(bannedCountry);
      });
    } catch (_) {
      rethrow;
    }
  }

  Future<void> removeBannedCountry(String country) async {
    try {
      await isar.writeTxn(() async {
        await isar.bannedCountrys.deleteByCountry(country);
      });
    } catch (_) {
      rethrow;
    }
  }

  Future<void> saveBannedCountries(List<String> countries) async {
    try {
      for (var country in countries) {
        BannedCountry? bannedCountry =
            isar.bannedCountrys.getByCountrySync(country);
        //Only insert if it doesn't exist
        await isar.writeTxn(() async {
          if (bannedCountry == null) {
            BannedCountry bannedCountry = BannedCountry()..country = country;
            await isar.bannedCountrys.put(bannedCountry);
          }
        });
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<List<BannedCountry>> getBannedCountries() async {
    return await isar.bannedCountrys.where().findAll();
  }

  Stream<List<CreditCard>> watchAllCreditCards() async* {
    final query = isar.creditCards.where().build();

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results;
      }
    }
  }

  Stream<List<BannedCountry>> watchBannedCountries() async* {
    final query = isar.bannedCountrys.where().build();

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results;
      }
    }
  }
}
