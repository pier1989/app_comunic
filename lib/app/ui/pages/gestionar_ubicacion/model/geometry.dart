import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/model/location.dart';
//import 'package:places_autocomplete/src/models/location.dart';

class Geometry {
  final Location location;

  Geometry({required this.location});

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
}
