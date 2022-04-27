import 'package:demo_flutter/Chapter6/db_helper.dart';
import 'package:demo_flutter/Chapter6/model/item.dart';
import 'package:demo_flutter/Chapter6/model/list.dart';
import 'package:flutter/material.dart';

class ShoppingItemDialog {
  final txtName = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtNote = TextEditingController();

  final DbHelper dbHelper = DbHelper();

  ShoppingItemDialog();

  Widget buildDialog(BuildContext context, ShoppingItem item, bool isNew) {
    if (!isNew) {
      txtName.text = item.name;
      txtQuantity.text = item.quantity;
      txtNote.text = item.note;
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text(
          isNew ? "New shopping item" : "Edit shopping item"
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                hintText: "Shopping item name",
              ),
            ),
            TextField(
              controller: txtQuantity,
              decoration: InputDecoration(
                hintText: "Quantity (1kg, 1 dozen)",
              ),
            ),
            TextField(
              controller: txtNote,
              decoration: InputDecoration(
                hintText: "Note",
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  item.name = txtName.text;
                  item.note = txtNote.text;
                  item.quantity = txtQuantity.text;
                  dbHelper.insertItem(item);
                  Navigator.pop(context);
                },
                child: Text('Save shopping item'))
          ],
        ),
      ),
    );
  }
}