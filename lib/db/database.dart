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
      [CreditCardSchema],
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

  Stream<List<CreditCard>> watchAllCreditCards() async* {
    final query = isar.creditCards.where().build();

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        yield results;
      }
    }
  }
}
