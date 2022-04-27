import 'package:demo_flutter/Chapter6/model/item.dart';
import 'package:demo_flutter/Chapter6/model/list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DbHelper {
  final int version = 2;
  Database? db;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    if (db != null) return db!;
    db = await openDatabase(
      join(await getDatabasesPath(), 'shopping.db'),
      onCreate: (database, version) {
        database.execute(
          'create table lists(id integer primary key, name text, priority integer)'
        );
        database.execute(
          'create table items(id integer primary key, listId integer, name text, quantity text, note text, foreign key(listid) references lists(id))'
        );
      },
      version: version);
    return db!;
  }

  Future<void> testDb() async {
    Database db = await openDb();
    await db.rawInsert(
        'INSERT INTO lists(name, priority) VALUES(?, ?)', ["Testing", 1]
    );
    await db.rawInsert(
      'insert into items (listId, name, quantity, note) values (?, ?, ?, ?)', [1, "Item 0", "1kg", "Better"]
    );

    List lists = await db.rawQuery('select * from lists');
    List items = await db.rawQuery('select * from items');

    print(lists.toString());
    print(items.toString());
  }

  Future<int> insertList(ShoppingLists list) async {
    Database db = await openDb();
    int id = await db.insert(
      'lists',
      list.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> insertItem(ShoppingItem item) async {
    Database db = await openDb();
    int id = await db.insert(
      'items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }


  Future<List<ShoppingLists>> getLists() async {
    Database db = await openDb();
    List<Map<String, dynamic>> lists = await db.query('lists');

    return List.generate(lists.length, (index) {
      var curr = lists[index];
      return ShoppingLists(
        curr['id'],
        curr['name'],
        curr['priority'],
      );
    });
  }

  Future<int> deleteLists(int id) async {
    Database db = await openDb();
    int did = await db.delete('lists', where: 'id = ?', whereArgs: [id]);
    return did;
  }

  Future<int> deleteItems(int id) async {
    Database db = await openDb();
    int did = await db.delete('items', where: 'id = ?', whereArgs: [id]);
    return did;
  }

  Future<List<ShoppingItem>> getItems(int listId) async {
    Database db = await openDb();
    List<Map<String, dynamic>> items = await db.query('items', where: 'listId = ?', whereArgs: [listId]);

    return List.generate(items.length, (index) {
      var curr = items[index];
      return ShoppingItem(
        curr['id'],
        curr['listId'],
        curr['name'],
        curr['quantity'],
        curr['note'],
      );
    });
  }
}