import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  Database db;


  NewsDbProvider() {
    init();
  }

  Future<List<int>> fetchTopIds() {
    return null;
  }

  void init() async {

    print("iniciei init");
    //returns a refrence to a folder to our mobile device where we can store
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) async {
     await newDb.execute("""
      CREATE TABLE Items
      (
        id INTEGER PRIMARY KEY,
        type TEXT,
        by TEXT,
        time INTEGER,
        text STRING,
        parent INTEGER,
        kids BLOB,
        dead INTEGER,
        deleted INTEGER,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER
      )
      """);
      },
    );


  }

  /// Vai buscar item com o id X
  /// retorna item ou null

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first); //first because id unique
    }
    return null;
  }

  Future<int> addItem(ItemModel item) {

    return db.insert(
        "Items",
        item.toMapForDb());
  }
}

final newsDbProvider = NewsDbProvider();
