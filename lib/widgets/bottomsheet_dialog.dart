import 'package:flutter/material.dart';

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "N E W  T R A N S A C T I O N",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(labelText: 'Name'),
              ),
            ),
            Center(
              child: TextField(
                decoration: InputDecoration(labelText: 'Amount'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Expense'),
                Switch(
                  value: false,
                  onChanged: (newValue) {},
                ),
                Text('Income'),
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
