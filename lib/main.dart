import 'package:flutter/material.dart';
import 'package:flutter_card_scanner/db/database.dart';
import 'package:flutter_card_scanner/services/custom_snackbar.dart';
import 'package:flutter_card_scanner/views/credit_cards/credit_cards_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Init database and schemas
  await DatabaseManager().initDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card scanner',
      scaffoldMessengerKey: CustomSnackbarService().rootScaffoldMessengerKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(child: CreditCardsView()),
    );
  }
}
