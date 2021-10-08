import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyValues {
  final String? key;
  final double? lat;
  final double? long;
  final num? phone;

  const MyValues({
    this.key,
    this.lat,
    this.long,
    this.phone,
  });

  factory MyValues.fromMap(Map json) => MyValues(
        key: json['key'],
        lat: double.parse(json['latitud']),
        long: double.parse(json['longitud']),
        phone: json['phone'],
      );

  Marker getMarker() {
    final MarkerId markerId = getMarkerID();
    final Marker marker =
        Marker(markerId: markerId, position: LatLng(lat ?? 0, long ?? 0));

    return marker;
  }

  MarkerId getMarkerID() => MarkerId(key ?? '');
}
