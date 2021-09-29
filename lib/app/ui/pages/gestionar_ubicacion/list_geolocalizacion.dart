import 'dart:async';
import 'dart:typed_data';
//import 'dart:html';

import 'package:app_comunic/app/ui/globald_widgets/rounded_buttom_forms.dart';
import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/bloc/places_function.dart';
import 'package:app_comunic/app/ui/pages/gestionar_ubicacion/model/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//const double ZOOM = 1;

/*
const double ZOOM = 1;

class MapList extends StatelessWidget {
  static GoogleMapController _googleMapController;
  Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Location").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            //Extract the location from document
            GeoPoint location = snapshot.data!.docs.first.get("location");

            // Check if location is valid
            if (location == null) {
              return Text("There was no location data");
            }

            // Remove any existing markers
            markers.clear();

            final latLng = LatLng(location.latitude, location.longitude);

            // Add new marker with markerId.
            markers
                .add(Marker(markerId: MarkerId("location"), position: latLng));

            // If google map is already created then update camera position with animation
            _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: latLng,
                zoom: ZOOM,
              ),
            ));

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(location.latitude, location.longitude)),
              // Markers to be pointed
              markers: markers,
              onMapCreated: (controller) {
                // Assign the controller value to use it later
                _googleMapController = controller;
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
*/
/*
class MapList extends StatefulWidget {
  const MapList({Key? key}) : super(key: key);

  @override
  _MapListState createState() => _MapListState();
}

class _MapListState extends State<MapList> {
  Completer<GoogleMapController> _controller = Completer();

  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  late LatLng currentLocation;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Set<Marker> _markers = Set();
  @override
  void initState() {
    super.initState();
    getMarkerData();
  }

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-12.078600, -76.977333),
    zoom: 17,
  );

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['latitud'].latitude, specify['longitud'].longitude),
      //   infoWindow: InfoWindow(title: specify['nombreSitio']),
    );
    setState(() {
      markers[markerId] = marker;
    });
    print(markerId);
    _markers.add(
      Marker(
        markerId: markerId,
        position:
            LatLng(specify['latitud'].latitude, specify['longitud'].longitude),
      ),
    );
    print(markerId);
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection('mark').get().then((markerData) {
      if (markerData.docs.isNotEmpty) {
        for (int i = 0; i < markerData.docs.length; ++i) {
          initMarker(markerData.docs[i].data(), markerData.docs[i].id);
        }
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    print(Set<Marker>.of(markers.values));
    print("Markers");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: true,
        title: Text(
          'Sitios',
          textAlign: TextAlign.center,
          // style: Colors.indigo.lightTheme.textTheme.headline2
        ),
        elevation: 4,
      ),
      floatingActionButton: FloatingActionButton.extended(
        //   onPressed: getMarkerData(),
        label: Text('Registrar!'),
        icon: Icon(Icons.directions_boat),
        onPressed: () {
          getMarkerData();
        },
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        myLocationButtonEnabled: false,
        // zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
*/

///op2

class MapList extends StatefulWidget {
  const MapList({Key? key}) : super(key: key);

  @override
  _MapListState createState() => _MapListState();
}

class _MapListState extends State<MapList> {
  Completer<GoogleMapController> _controller = Completer();

  //GoogleMapController controller;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(38.12585158237043, -92.71793095533938),
      // infoWindow: InfoWindow(title: 'Shop', snippet: specify['nombreSiio']),
    );
    setState(() {
      markers[markerId] = marker;
      print(markerId);
    });
  }

  getMarkerData() async {
    FirebaseFirestore.instance.collection('mark').get().then((myMockDoc) {
      if (myMockDoc.docs.isNotEmpty) {
        for (int i = 0; i < myMockDoc.docs.length; i++) {
          initMarker(myMockDoc.docs[i].data(), myMockDoc.docs[i].id);
        }
      }
    });
  }

  @override
  void initState() {
    getMarkerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Set<Marker>.of(markers.values));
    print("Markers");
    Set<Marker> getMarker() {
      return <Marker>[
        Marker(
            markerId: MarkerId('Shop'),
            position: LatLng(21.1458, 79.0882),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: 'Home'))
      ].toSet();
    }

    return Scaffold(
        body: GoogleMap(
            markers: Set<Marker>.of(markers.values),
            mapType: MapType.normal,
            initialCameraPosition:
                CameraPosition(target: LatLng(21.1458, 79.0882), zoom: 12.0),
            onMapCreated: (GoogleMapController controller) {
              controller = controller;
            }));
  }
}



//op3
/*
class MapList extends StatefulWidget {
  const MapList({Key? key}) : super(key: key);

  @override
  _MapListState createState() => _MapListState();
}

class _MapListState extends State<MapList> {
  Completer<GoogleMapController> _controller = Completer();

  bool mapToggle = false;

  var currentLocation;

  //GoogleMapController mapController;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  getMarkerData() async {
    FirebaseFirestore.instance.collection('markers').get().then((myMarkers) {
      if (myMarkers.docs.isNotEmpty) {
        for (int i = 0; i < myMarkers.docs.length; i++) {
          initMarker(myMarkers.docs[i].data(), myMarkers.docs[i].id);
        }
      }
    });
  }

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      //  infoWindow: InfoWindow(title: 'HvD Stations' , snippet: specify['stationAddress']),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void initState() {
    getMarkerData();
    super.initState();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height - 80.0,
                width: double.infinity,
                child: mapToggle
                    ? GoogleMap(
                        onMapCreated: onMapCreated,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation.latitude,
                              currentLocation.longitude),
                          zoom: 10.0,
                        ),
                        markers: Set<Marker>.of(markers.values),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ))
          ],
        ),
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
}  
*/

//*/
//}
/*
class MapList extends StatefulWidget {
  const MapList({Key? key}) : super(key: key);

  @override
  _MapListState createState() => _MapListState();
}

class _MapListState extends State<MapList> {
  //late GoogleMapController mycontroler;
  // Completer<GoogleMapController> _controller = Completer();
  final FirebaseFirestore _database = FirebaseFirestore.instance;
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  crearmarcadores() {
    _database.collection('ubicacion').get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
  }

  void initMarker(lugar, lugaresid) {
    var markerIdVal = lugaresid;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lugar['location'], lugar['location']),
      // infoWindow: InfoWindow(title: lugar['Lugar'], snippet: lugar['tipo']),
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-12.0786, -76.977333),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        markers: Set<Marker>.of(markers.values),
      ),
      floatingActionButton: FloatingActionButton.extended(
        //  onPressed: _currentLocation,
        label: Text('Ir a mi Ubicacion!'),
        icon: Icon(Icons.location_on), onPressed: () {},
      ),
    );
  }


*/



/*

void _currentLocation() async {
   final GoogleMapController controller = await _controller.future;
   Location currentLocation;
   var location =  Location;
   try {
     currentLocation = await location.getLocation();
     } on Exception {
       currentLocation = null;
       }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.lat, currentLocation.lng),
        zoom: 17.0,
      ),
    ));
  }

}
*/

/*

//opcion mmmm

class MapList extends StatefulWidget {
  @override
  _MarkerPageState createState() => _MarkerPageState();
}

class _MarkerPageState extends State<MapList> {
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  late MarkerId selectedMarker;
  int _markerIdCounter = 1;
  bool _initialized = false;
  bool _error = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late GoogleMapController _controller;
  static final CameraPosition _initCamPos = CameraPosition(
    target: LatLng(38.12585158237043, -92.71793095533938),
    zoom: 15.4746,
  );

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  static final CameraPosition _resort = CameraPosition(
      bearing: 340,
      target: LatLng(38.12585158237043, -92.71793095533938),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Algo fallo'),
        ),
      );
    }
    if (!_initialized) {
      return CircularProgressIndicator();
    }

    return new Scaffold(
      body: Stack(children: [
        GoogleMap(
          markers: Set<Marker>.of(_markers.values),
          mapType: MapType.hybrid,
          initialCameraPosition: _initCamPos,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
            _readData();
          },
          onTap: _handleTap,
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onPressed: _goToResort,
              child: Icon(Icons.directions_boat_rounded)),
        ),
        Positioned(
          bottom: 10,
          right: 100,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onPressed: _removeMarker,
            child: Icon(Icons.delete),
          ),
        )
      ], overflow: Overflow.clip),
    );
  }

  void _removeMarker() {
    if (selectedMarker != null) {
      firestore.collection('places').doc(selectedMarker.value).delete();
      setState(() {
        _markers.remove(selectedMarker);
      });
    }
  }

  void _readData() async {
    final QuerySnapshot result = await firestore.collection('marker').get();
    final List<DocumentSnapshot> documents = result.docs;
    int count = 0;
    documents.forEach((data) {
      // DocumentSnapshot<Object?> datos = data;
      Map<String, dynamic> datos = data as Map<String, dynamic>;
      GeoPoint tmp = datos['location'];
      if (count < int.parse(data.id)) count = int.parse(data.id);
      final MarkerId markerId = MarkerId(data.id);
      LatLng point = LatLng(tmp.latitude, tmp.longitude);
      final Marker marker = Marker(
          markerId: markerId,
          position: point,
          infoWindow: InfoWindow(title: 'Id: ' + data.id),
          onTap: () {
            _onTapped(markerId);
          },
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueYellow));
      _markers[markerId] = marker;
    });
    _markerIdCounter = count + 1;
    setState(() {});
  }

  Future<void> _goToResort() async {
    _controller.animateCamera(CameraUpdate.newCameraPosition(_resort));
  }

  void _handleTap(LatLng point) {
    final MarkerId markerId = MarkerId(_markerIdCounter.toString());
    GeoPoint geoPoint = GeoPoint(point.latitude, point.longitude);
    final Marker marker = Marker(
        markerId: markerId,
        position: point,
        infoWindow: InfoWindow(title: 'Id: ' + _markerIdCounter.toString()),
        onTap: () {
          _onTapped(markerId);
        },
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow));
    firestore
        .collection('marker')
        .doc(_markerIdCounter.toString())
        .set({"location": geoPoint});
    setState(() {
      _markers[markerId] = marker;
    });
    _markerIdCounter++;
  }

  void _onTapped(MarkerId markerId) {
    final Marker? tappedMarker = _markers[markerId];
    if (tappedMarker != null) {
      if (_markers.containsKey(markerId)) {
        selectedMarker = markerId;
      }
    }
  }
}
*/