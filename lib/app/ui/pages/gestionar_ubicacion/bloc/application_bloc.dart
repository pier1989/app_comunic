import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/services/geolocator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class Applicationbloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();

  late Position currentLocation;

  Applicationbloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
  }
}
