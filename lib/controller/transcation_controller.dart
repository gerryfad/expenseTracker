import 'package:expense_tracker/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import '../boxes.dart';

class TransactionController extends GetxController {
  late TextEditingController amountController;
  late TextEditingController nameController;
  late Box<Transaction> box;
  bool isExpense = true;

  @override
  void onInit() async {
    amountController = TextEditingController();
    nameController = TextEditingController();
    box = Boxes.getTransactions();

    super.onInit();
  }

  @override
  void onClose() {
    nameController.dispose();
    amountController.dispose();
    Hive.box('transaction').close();

    super.onClose();
  }

  void switchIncome(bool value) {
    isExpense = value;
    update();
  }

  double expense() {
    double expense = 0;
    final transcationList = box.values.toList();
    for (var i = 0; i < transcationList.length; i++) {
      if (transcationList[i].isExpense == true) {
        expense = expense + transcationList[i].amount;
      }
    }
    return expense;
  }

  double income() {
    double income = 0;
    final transcationList = box.values.toList();
    for (var i = 0; i < transcationList.length; i++) {
      if (transcationList[i].isExpense == false) {
        income = income + transcationList[i].amount;
      }
    }
    return income;
  }

  double balance() {
    double balance = 0;
    double income = 0;
    double expense = 0;
    final transcationList = box.values.toList();
    for (var i = 0; i < transcationList.length; i++) {
      if (transcationList[i].isExpense == true) {
        expense = expense + transcationList[i].amount;
      }
      if (transcationList[i].isExpense == false) {
        income = income + transcationList[i].amount;
      }

      balance = income - expense;
    }
    return balance;
  }

  String convertToIdr(dynamic number) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
    );
    return currencyFormatter.format(number);
  }

  Future addTranscation(String name, double amount, bool isExpense) async {
    final transaction = Transaction()
      ..name = name
      ..createdDate = DateTime.now()
      ..amount = amount
      ..isExpense = isExpense;
    final box = Boxes.getTransactions();
    box.add(transaction);
  }

  void deleteTransaction(int index) async {
    final box = Boxes.getTransactions();
    box.deleteAt(index);
  }
}
