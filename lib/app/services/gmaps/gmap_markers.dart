import 'dart:async';

import 'package:app_comunic/app/services/firebase/models.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'gmaps_utils.dart';

class GMapMarkers extends StatefulWidget {
  final Map<MarkerId, Marker> markers;
  final MyValues? selected;
  const GMapMarkers({Key? key, required this.markers, this.selected})
      : super(key: key);

  @override
  _GMapMarkersState createState() => _GMapMarkersState();
}

class _GMapMarkersState extends State<GMapMarkers> {
  final Completer<GoogleMapController> _controller = Completer();

  var latlong = const LatLng(-10.0786, -70.977333);

  getMarkerData() async {
    if (widget.markers.values.isNotEmpty) {
      final latlng = widget.markers.values.first.position;

      Future.delayed(const Duration(milliseconds: 700), () {
        updateCameraPosition(latlng);
      });
    }

    if (widget.selected != null) {
      final selected = widget.selected?.getMarker();

      if (selected != null) {
        updateCameraPosition(selected.position);
      }
    }

    setState(() {});
  }

  void updateCameraPosition(LatLng latlng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(GMapsUtils.updatedCamera(latlng));
  }

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GMapMarkers oldWidget) {
    if (oldWidget.selected != widget.selected) {
      if (widget.selected != null) {
        final selected = widget.selected?.getMarker();

        if (selected != null) {
          updateCameraPosition(selected.position);
        }
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
            markers: Set<Marker>.of(widget.markers.values),
            mapType: MapType.normal,
            initialCameraPosition: GMapsUtils.getCameraPosition(latlong),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }));
  }
}
