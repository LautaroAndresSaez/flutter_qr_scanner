import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/models/navigator_option.dart';
import 'package:qr_scanner/providers/index_provider.dart';

class NavigationBar extends StatelessWidget {
  final List<NavigatorOption> _options = [
    NavigatorOption(Icons.map, 'Mapa'),
    NavigatorOption(Icons.compass_calibration, 'Urls')
  ];

  @override
  Widget build(BuildContext context) {
    final _indexProvider = Provider.of<IndexProvider>(context);

    return BottomNavigationBar(
        currentIndex: _indexProvider.currentOption,
        onTap: (i) {
          _indexProvider.currentOption = i;
        },
        elevation: 0,
        items: _options
            .map((option) => BottomNavigationBarItem(
                icon: Icon(option.icon), label: option.label))
            .toList());
  }
}
