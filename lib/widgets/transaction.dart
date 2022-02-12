import 'package:expense_tracker/controller/transcation_controller.dart';
import 'package:expense_tracker/model/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyTransaction extends GetView<TransactionController> {
  final String transactionName;
  final String money;
  final bool expenseOrIncome;
  final DateTime createdDate;
  final Transaction transaction = Transaction();
  final int deleteKey;
  final controller = Get.put(TransactionController());

  MyTransaction({
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
    required this.createdDate,
    required this.deleteKey,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 65,
          padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[500]),
                    child: Center(
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transactionName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        (DateFormat.yMMMMd().format(createdDate)),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    (expenseOrIncome == true ? '-' : '+') +
                        'Rp ' +
                        money.toString(),
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color:
                          expenseOrIncome == true ? Colors.red : Colors.green,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {
                      Get.bottomSheet(
                          Container(
                            height: Get.height * 0.2,
                            child: Wrap(
                              children: <Widget>[
                                ListTile(
                                    leading: Icon(CupertinoIcons.delete),
                                    title: Text('Delete'),
                                    onTap: () => {
                                          controller
                                              .deleteTransaction(deleteKey),
                                          Navigator.of(context).pop()
                                        }),
                                ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text('Edit'),
                                  onTap: () => {},
                                ),
                              ],
                            ),
                          ),
                          backgroundColor: Colors.white);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
