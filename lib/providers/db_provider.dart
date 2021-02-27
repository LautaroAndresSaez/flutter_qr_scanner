import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:qr_scanner/models/scan.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static Database _database;
  static final String _tableName = 'Scans';
  static final DbProvider db = DbProvider._();

  DbProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    //Path de la db
    Directory documentsDirectoy = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectoy.path, 'ScansDB.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
       CREATE TABLE $_tableName(
         id INTEGER PRIMARY KEY,
         type TEXT,
         value TEXT
       ) 
      ''');
    });
  }

  Future<int> newScan(Scan scan) async {
    final _db = await database;
    final lastId = await _db.insert(_tableName, scan.toJson());
    return lastId;
  }

  Future<Scan> getScanById(int id) async {
    final db = await database;
    final res = await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (res.isEmpty) return null;
    print(res);
    return Scan.fromJson(res.first);
  }

  Future<List<Scan>> getScanByType(String type) async {
    final db = await database;
    final res =
        await db.query(_tableName, where: 'type = ?', whereArgs: [type]);
    if (res.isEmpty) return [];
    return res.map((s) => Scan.fromJson(s)).toList();
  }

  Future<List<Scan>> getScans() async {
    final db = await database;
    final res = await db.query(_tableName);
    if (res.isEmpty) return [];
    return res.map((s) => Scan.fromJson(s)).toList();
  }

  Future<int> updateScan(Scan scan) async {
    final db = await database;
    final res = await db.update(_tableName, scan.toJson(),
        where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteScan() async {
    final db = await database;
    final res = await db.delete(_tableName);
    return res;
  }
}
