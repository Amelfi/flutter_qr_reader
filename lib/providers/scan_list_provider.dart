import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/models/models.dart';
import 'package:flutter_qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  late List<ScanModel> scanList = [];
  late String getTipo = 'http';

  Future<ScanModel> addNewScan(String valor) async {
    final newScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(newScan);
    newScan.id = id;

    if (newScan.tipo == getTipo) {
      scanList.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  getScans() async {
    final scans = await DBProvider.db.getAllScan();
    scanList = [...scans];
    notifyListeners();
  }

  getScansByType(String tipo) async {
    print(tipo);
    final scans = await DBProvider.db.getScanByType(tipo);

    // scanList.clear;
    scanList = [...scans];
    getTipo = tipo;
    notifyListeners();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScan();
    scanList = [];
    notifyListeners();
  }

  deleteScansById(int id) async {
    // print(id);
    await DBProvider.db.deleteScanById(id);
    // notifyListeners();
  }
}
