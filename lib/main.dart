import 'package:expense_tracker/model/transaction.dart';
import 'package:expense_tracker/screen/transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>('transaction');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Hive Expense App';

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.grey),
        home: TransactionView(),
      );
}
