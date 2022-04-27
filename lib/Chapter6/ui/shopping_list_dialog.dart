import 'package:demo_flutter/Chapter6/db_helper.dart';
import 'package:demo_flutter/Chapter6/model/list.dart';
import 'package:flutter/material.dart';

class ShoppingListDialog {
  final txtName = TextEditingController();
  final txtPriority = TextEditingController();

  final DbHelper dbHelper = DbHelper();

  Widget buildDialog(BuildContext context, ShoppingLists list, bool isNew) {
    if (!isNew) {
      txtName.text = list.name;
      txtPriority.text = list.priority.toString();
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text(
        isNew ? "New shopping list" : "Edit shopping list"
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                hintText: "Shopping list name",
              ),
            ),
            TextField(
              controller: txtPriority,
              decoration: InputDecoration(
                hintText: "Shopping list priority (1-3)",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  list.name = txtName.text;
                  list.priority = int.parse(txtPriority.text);
                  dbHelper.insertList(list);
                  Navigator.pop(context);
                },
                child: Text('Save shopping list'))
          ],
        ),
      ),
    );
  }
}