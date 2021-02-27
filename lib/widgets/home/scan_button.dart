import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_provider.dart';
import 'package:qr_scanner/utils/launch_url.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () => runScan(context),
    );
  }

  runScan(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#3D8DEF', 'Cancelar', false, ScanMode.QR);

    final _scanProvider = Provider.of<ScanProvider>(context, listen: false);
    if (barcodeScanRes == '-1') {
      return;
    }
    final scan = await _scanProvider.newScan(barcodeScanRes);

    launchScan(context, scan);
  }
}
