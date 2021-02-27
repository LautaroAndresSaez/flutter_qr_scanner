import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/history.dart';

import 'package:qr_scanner/providers/index_provider.dart';
import 'package:qr_scanner/providers/scan_provider.dart';
import 'package:qr_scanner/widgets/home/navigation_bar.dart';
import 'package:qr_scanner/widgets/home/scan_button.dart';

class Home extends StatelessWidget {
  static final route = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              final _scanProvider =
                  Provider.of<ScanProvider>(context, listen: false);
              _scanProvider.deleteScans();
            },
          )
        ],
      ),
      body: _Body(),
      bottomNavigationBar: NavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _indexProvider = Provider.of<IndexProvider>(context);
    final _scanProvider = Provider.of<ScanProvider>(context, listen: false);
    switch (_indexProvider.currentOption) {
      case 0:
        _scanProvider.changeType('geo');
        break;
      case 1:
        _scanProvider.changeType('http');
        break;
      default:
        _scanProvider.changeType('geo');
        _indexProvider.currentOption = 0;
    }

    return History();
  }
}
