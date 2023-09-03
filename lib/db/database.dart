import 'dart:async';

import 'package:flutter_card_scanner/views/countries/select_banned_countries.dart';
import 'package:flutter_card_scanner/db/models/banned_countries.dart';
import 'package:flutter_card_scanner/db/models/credit_card.dart';
import 'package:flutter_card_scanner/models/exceptions.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  //Singleton access acroos the app
  static final DatabaseManager _instance = DatabaseManager._internal();

  late Isar isar;

  final StreamController<List<BannedCountry>> _bannedCountriesController =
      StreamController<List<BannedCountry>>.broadcast();

  Stream<List<BannedCountry>> get onCountryAdded =>
      _bannedCountriesController.stream;

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

  void removeCard(CreditCard creditCard) {
    isar.writeTxnSync(() {
      isar.creditCards.deleteByCardNumberSync(creditCard.cardNumber);
    });
  }

  void addBannedCountry(String country) {
    try {
      BannedCountry? bannedCountry =
          isar.bannedCountrys.getByCountrySync(country);
      if (bannedCountry == null) {
        isar.writeTxnSync(() {
          BannedCountry bannedCountry = BannedCountry()..country = country;
          isar.bannedCountrys.putSync(bannedCountry);
        });
      } else {
        isar.writeTxnSync(() {
          isar.bannedCountrys.deleteByCountrySync(country);
        });
      }
    } catch (_) {
      rethrow;
    }
  }

  void removeBannedCountry(String country) {
    try {
      isar.writeTxnSync(() {
        isar.bannedCountrys.deleteByCountrySync(country);
      });
    } catch (_) {
      rethrow;
    }
  }

  void clearBannedCountries() {
    try {
      final bannedCountries = isar.bannedCountrys.where().findAllSync();
      for (var bannedCountry in bannedCountries) {
        isar.writeTxnSync(() {
          isar.bannedCountrys.deleteSync(bannedCountry.id);
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
    yield* isar.creditCards.where().watch(fireImmediately: true);
  }

  Stream<void> watchCollection() async* {
    yield* isar.bannedCountrys.watchLazy(fireImmediately: true);
  }

  Stream<List<BannedCountry>> watchBannedCountries() async* {
    yield* isar.bannedCountrys.where().watch(fireImmediately: true);
  }
}
