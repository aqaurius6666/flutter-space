import 'package:demo_flutter/Chapter6/db_helper.dart';
import 'package:demo_flutter/Chapter6/model/list.dart';
import 'package:demo_flutter/Chapter6/ui/items_screen.dart';
import 'package:demo_flutter/Chapter6/ui/shopping_list_dialog.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);


  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  DbHelper dbHelper = DbHelper();
  late List<ShoppingLists> shoppingList = [];
  late int listCount = 0;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
    var sshoppingList = await dbHelper.getLists();
    setState(() {
      shoppingList = sshoppingList;
      listCount = shoppingList.length;
    });
  }

  Future<void> refreshData() async {
    var sshoppingList = await dbHelper.getLists();
    setState(() {
      shoppingList = sshoppingList;
      listCount = shoppingList.length;
    });
  }
  @override
  Widget build(BuildContext context) {
    refreshData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách cho người đãng trí"),
      ),
      body: ListView.builder(
        itemCount: shoppingList.length,
        itemBuilder: (BuildContext context, int index) {
          var listDialog = ShoppingListDialog();
          var curr = shoppingList[index];
          return Dismissible(
            key: Key('list' + curr.id.toString()),
            onDismissed: (direction) {
              String strName = curr.name;
              dbHelper.deleteLists(curr.id!);
              setState(() {
                shoppingList.removeAt(index);
              });
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("$strName deleted!")));
            },
            child: ListTile(
              title: Text(curr.name),
              leading: CircleAvatar(
                child: Text(curr.priority.toString()),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  showDialog(context: context, builder: (builder) => listDialog.buildDialog(context, curr, false));
                },
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ItemsScreen(curr)));
              },

            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          var listDialog = ShoppingListDialog();
          showDialog(
              context: context,
              builder: (builder) => listDialog.buildDialog(context, ShoppingLists(0, '', 0), true)
          );
        },
      ),
    );
  }
}
