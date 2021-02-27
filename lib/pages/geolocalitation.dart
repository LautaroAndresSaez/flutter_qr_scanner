import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_scanner/models/scan.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Geolocalitation extends StatefulWidget {
  static final route = 'map';

  @override
  _GeolocalitationState createState() => _GeolocalitationState();
}

class _GeolocalitationState extends State<Geolocalitation> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final Scan scan = ModalRoute.of(context).settings.arguments;
    final CameraPosition _kGooglePlex =
        CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 50);

    Set<Marker> markers = Set<Marker>();

    MapType mapType = MapType.normal;

    markers.add(
        Marker(markerId: MarkerId('ubicacion'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_city),
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;
              controller
                  .animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
            },
          )
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: mapType,
        initialCameraPosition: _kGooglePlex,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
              return;
            }
            mapType = MapType.normal;
          });
        },
        child: Icon(Icons.layers),
      ),
    );
  }
}
