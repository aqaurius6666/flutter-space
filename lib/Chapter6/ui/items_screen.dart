import 'package:demo_flutter/Chapter6/db_helper.dart';
import 'package:demo_flutter/Chapter6/model/item.dart';
import 'package:demo_flutter/Chapter6/model/list.dart';
import 'package:demo_flutter/Chapter6/ui/shopping_item_dialog.dart';
import 'package:flutter/material.dart';

class ItemsScreen extends StatefulWidget {

  final ShoppingLists shoppingList;

  ItemsScreen(this.shoppingList);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState(shoppingList);
}

class _ItemsScreenState extends State<ItemsScreen> {

  final ShoppingLists shoppingLists;

  DbHelper dbHelper = DbHelper();
  late List<ShoppingItem> items = [];
  late int itemsCount = 0;

  _ItemsScreenState(this.shoppingLists);

  @override
  void initState() {
    initialize();
    super.initState();
  }
  Future<void> initialize() async {
    await refreshData();
  }
  Future<void> refreshData() async {
    dbHelper.openDb();
    var tmp = await dbHelper.getItems(shoppingLists.id!);
    setState(() {
      items = tmp;
      itemsCount = tmp.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshData();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          var dialog = ShoppingItemDialog();
          showDialog(
              context: context,
              builder: (BuildContext builder) {
                return dialog.buildDialog(context, ShoppingItem(0, shoppingLists.id!, "", "", ""), true);
              });
        },
      ),
      appBar: AppBar(
        title: Text(shoppingLists.name),
      ),
      body: ListView.builder(
        itemCount: itemsCount,
        itemBuilder: (BuildContext context, int index) {
          var cur = items[index];
          var dialog = ShoppingItemDialog();
          return Dismissible(
            key: Key('item' + cur.id.toString()),
            onDismissed: (direction) {
              String strName = cur.name;
              dbHelper.deleteItems(cur.id!);
              setState(() {
                items.removeAt(index);
              });
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("$strName deleted!")));
            },
            child: ListTile(
              title: Text(cur.name),
              subtitle: Text(
                'Quantity: ' + cur.quantity + ' - Note: ' + cur.note
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                showDialog(context: context, builder: (builder) => dialog.buildDialog(context, cur, false));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
