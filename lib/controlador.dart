import 'dart:io';

import 'package:sergio_hernandez_nunez_btc/ordre.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseHelper {
  // database
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/ordre.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE tbl_ordre (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  tipus TEXT,
                  quantitat INTEGER )
    
    ''');
  }
  // insert
  void setOrdre(tipus,quantitat){
    Ordre().setOrdre(tipus, quantitat);
    insertOrdre(Ordre());
  }
  void actualizarOrdre(tipus,quantitat){
    Ordre().setOrdre(tipus, quantitat);
    updateOrdre(Ordre());
  }
  Future<int> insertOrdre(Ordre ordre) async {


    Database db = await instance.database;
    int result = await db.insert('tbl_ordre', ordre.toMap());
    return result;
  }

  // read operation
  Future<List<Ordre>> getAllOrdres() async {
    List<Ordre> ordres = [];

    Database db = await instance.database;

    // read data from table
    List<Map<String, dynamic>> listMap = await db.query('tbl_ordre');

    for (var ordreMap in listMap) {
      Ordre ordre = Ordre.fromMap(ordreMap);
      ordres.add(ordre);
    }

    return ordres;
  }


  // delete
  Future<int> deleteOrdre(int id) async {
    Database db = await instance.database;
    int result = await db.delete('tbl_ordre', where: 'id=?', whereArgs: [id]);
    return result;
  }

  // update
  Future<int> updateOrdre(Ordre ordre) async {
    Database db = await instance.database;
    int result = await db.update('tbl_ordre', ordre.toMap(), where: 'id=?', whereArgs: [ordre.id]);
    return result;
  }

}