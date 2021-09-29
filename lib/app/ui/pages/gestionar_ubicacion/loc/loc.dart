import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FireMap extends StatefulWidget {
  @override
  State createState() => FireMapState();
}

class FireMapState extends State<FireMap> {
  late GoogleMapController mapController;

  build(context) {
    return Stack(children: [
      GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(24.150, -110.32), zoom: 10),
        onMapCreated: _onMapCreated,
        myLocationEnabled:
            true, // Add little blue dot for device location, requires permission from user
        mapType: MapType.hybrid,
        // trackCameraPosition: true
      ),
      Positioned(
          bottom: 50,
          right: 10,
          child: FlatButton(
              child: Icon(Icons.pin_drop),
              color: Colors.green,
              onPressed: () => _addMarker()))
    ]);
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  _addMarker() {}
}
