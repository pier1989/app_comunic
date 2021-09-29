import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/model/geometry.dart';
//import 'package:places_autocomplete/src/models/geometry.dart';

class Place {
  final Geometry geometry;
  final String name;
  final String vicinity;

  Place({required this.geometry, required this.name, required this.vicinity});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: Geometry.fromJson(json['geometry']),
      name: json['formatted_address'],
      vicinity: json['vicinity'],
    );
  }
}
