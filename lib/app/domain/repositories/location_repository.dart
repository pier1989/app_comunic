import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationRepository with ChangeNotifier {
  var latitude;
  var longitude;

  Future<void> getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    this.latitude = position.latitude;
    this.longitude = position.longitude;
    if (position != null) {
      this.latitude = position.latitude;
      this.longitude = position.longitude;
      notifyListeners();
    } else {
      print('Permission not allowed');
    }
  }
}
