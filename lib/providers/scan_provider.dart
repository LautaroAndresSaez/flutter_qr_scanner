import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan.dart';
import 'package:qr_scanner/providers/db_provider.dart';

class ScanProvider extends ChangeNotifier {
  List<Scan> scans = [];
  String selectedType = 'http';

  newScan(value) async {
    final scan = Scan(value: value);
    final id = await DbProvider.db.newScan(scan);
    scan.id = id;
    if (scan.type == selectedType) {
      scans.add(scan);
      notifyListeners();
    }
    return scan;
  }

  loadScans() async {
    scans = await DbProvider.db.getScans();
    notifyListeners();
  }

  changeType(String type) async {
    if (type == selectedType) {
      return;
    }
    selectedType = type;
    scans = await DbProvider.db.getScanByType(type);
    notifyListeners();
  }

  deleteScans() async {
    await DbProvider.db.deleteScan();
    scans = [];
    notifyListeners();
  }

  deleteScanById(int id) async {
    await DbProvider.db.deleteScanById(id);
    scans = scans.where((scan) => scan.id != id).toList();
    notifyListeners();
  }
}
