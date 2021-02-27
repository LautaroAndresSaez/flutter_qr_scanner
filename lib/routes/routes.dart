import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/geolocalitation.dart';
import 'package:qr_scanner/pages/home.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    Home.route: (context) => Home(),
    Geolocalitation.route: (context) => Geolocalitation(),
  };
}
