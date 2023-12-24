import 'dart:io';

// import 'package:flutter/foundation.dart';
import 'package:flutter_qr_reader/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    //path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
            )
        ''');
    });
  }

  // nuevoScanRaw(ScanModel nuevoScan) async {
  //   final id = nuevoScan.id;
  //   final tipo = nuevoScan.tipo;
  //   final valor = nuevoScan.valor;

  //   final db = await database;

  //   final res = await db.rawInsert('''
  //     INSERT INTO Scans(id, tipo, valor)
  //     VALUES ($id, '$tipo', '$valor')
  //   ''');

  //   return res;
  // }

  nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    // El res es el id del regitro creado
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty
        ? ScanModel.fromJson(res.first)
        : throw Exception('ScanModel not found for id: $id');
  }

  Future<List<ScanModel>> getAllScan() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScanByType(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
        ? res.map( (s) => ScanModel.fromJson(s) ).toList()
        : [];
  }

  Future<int> updateScanById(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }
  
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }
}
