import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMapsUtils {
  static const zoomLvl = 12.0;
  static CameraPosition getCameraPosition(LatLng latlng) =>
      CameraPosition(target: latlng, zoom: zoomLvl);

  static CameraUpdate updatedCamera(LatLng latlng) =>
      CameraUpdate.newCameraPosition(GMapsUtils.getCameraPosition(latlng));
}
