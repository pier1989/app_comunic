import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final Set<Marker> _markers = Set();

Completer<GoogleMapController> _controller = Completer();

final CameraPosition _ubicacionInicial = const CameraPosition(
  target: LatLng(-0.180653, -78.467834),
  zoom: 14.4746,
);

CameraPosition camPosicionUbicacion = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(-0.180653, -78.467834),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414);

Future<void> _goToTheLake() async {
  _getUbicacionActual();
  final GoogleMapController controller = await _controller.future;
  controller
      .animateCamera(CameraUpdate.newCameraPosition(camPosicionUbicacion));
}

Future<void> _getUbicacionActual() async {
  //objeto geolocator que obtendra la ubicaciionactual
  final Geolocator geolocator = Geolocator();

  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) async {
    setState(() {
      //imprimir la posicion actual en log
      print(position);
      //Actualizar  camera position
      camPosicionUbicacion = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(position.latitude, position.longitude),
          tilt: 59.440717697143555,
          zoom: 19.151926040649414);
    });
    //agregar marcador con ubicacion actual
    _markers.add(
      Marker(
        markerId: MarkerId('newyork'),
        position: LatLng(position.latitude, position.longitude),
      ),
    );
    //crear controller google map
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newCameraPosition(camPosicionUbicacion));
  }).catchError((e) {
    print(e);
  });
}

Future<void> _goToNewYork() async {
  double lat = 40.7128;
  double long = -74.0060;
  GoogleMapController controller = await _controller.future;
  controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), 10));
  setState(() {
    _markers.add(
      Marker(
        markerId: MarkerId('Tu ubicacion'),
        position: LatLng(lat, long),
      ),
    );
  });
}

void setState(Null Function() param0) {}
