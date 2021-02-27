import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

Scan scanFromJson(String str) => Scan.fromJson(json.decode(str));

String scanToJson(Scan data) => json.encode(data.toJson());

class Scan {
  Scan({
    this.id,
    this.type,
    @required this.value,
  }) {
    if (this.value.contains('http')) {
      this.type = 'http';
      return;
    }
    if (this.value.contains('geo')) {
      this.type = 'geo';
      return;
    }
  }

  int id;
  String type;
  String value;

  factory Scan.fromJson(Map<String, dynamic> json) => Scan(
        id: json["id"],
        type: json['type'],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };

  LatLng getLatLng() {
    final latLng = value.substring(4).split(',');
    return LatLng(double.parse(latLng[0]), double.parse(latLng[1]));
  }
}
