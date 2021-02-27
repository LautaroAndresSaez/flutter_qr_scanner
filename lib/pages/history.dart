import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/scan.dart';

import 'package:qr_scanner/providers/scan_provider.dart';
import 'package:qr_scanner/utils/launch_url.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);

    final scans = scanProvider.scans;

    final itemIcon =
        scanProvider.selectedType == 'geo' ? Icons.map : Icons.home_outlined;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (context, index) {
          final Scan scan = scans[index];
          return Dismissible(
            key: Key('${scan.id}'),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              final _scanProvider =
                  Provider.of<ScanProvider>(context, listen: false);
              _scanProvider.deleteScanById(scan.id);
            },
            child: ListTile(
              leading: Icon(
                itemIcon,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('${scan.value}'),
              subtitle: Text('${scan.id}'),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => launchScan(context, scan),
            ),
          );
        });
  }
}
