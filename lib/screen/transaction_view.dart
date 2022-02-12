import 'package:expense_tracker/controller/transcation_controller.dart';
import 'package:expense_tracker/widgets/balance_card.dart';
import 'package:expense_tracker/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';
import 'package:get/get.dart';

class TransactionView extends GetView<TransactionController> {
  final controller = Get.put(TransactionController());
  final nominal = NumberFormat(",###");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ValueListenableBuilder<Box<Transaction>>(
            valueListenable: controller.box.listenable(),
            builder: (context, box, _) {
              final transactionList = box.values.toList();
              return Column(
                children: [
                  BalanceCard(
                    balance: nominal.format(controller.balance()),
                    income: nominal.format(controller.income()),
                    expense: nominal.format(controller.expense()),
                  ),
                  Container(
                    height: Get.height * 0.55,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (context, index) => MyTransaction(
                                transactionName: transactionList[index].name,
                                money: nominal
                                    .format(transactionList[index].amount),
                                expenseOrIncome:
                                    transactionList[index].isExpense,
                                createdDate: transactionList[index].createdDate,
                                deleteKey: index,
                              ),
                              itemCount: transactionList.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            BottomSheet(),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class BottomSheet extends GetView<TransactionController> {
  final controller = Get.put(TransactionController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                "N E W  T R A N S A C T I O N",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: TextField(
                controller: controller.nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            Center(
              child: TextField(
                controller: controller.amountController,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Income'),
                GetBuilder<TransactionController>(
                  init: TransactionController(),
                  builder: (controller) => Switch(
                    value: controller.isExpense,
                    onChanged: (value) {
                      controller.switchIncome(value);
                    },
                  ),
                ),
                Text('Expense'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.grey[600],
                  child: Text('Cancel', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  color: Colors.grey[600],
                  child: Text('Enter', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    controller.addTranscation(
                        controller.nameController.text,
                        double.tryParse(controller.amountController.text) ?? 0,
                        controller.isExpense);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
