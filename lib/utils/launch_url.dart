import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan.dart';
import 'package:qr_scanner/pages/geolocalitation.dart';
import 'package:url_launcher/url_launcher.dart';

launchScan(BuildContext context, Scan scan) async {
  if (scan.type == 'http') {
    _launchUrl(scan.value);
    return;
  }
  Navigator.pushNamed(context, Geolocalitation.route, arguments: scan);
}

_launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
