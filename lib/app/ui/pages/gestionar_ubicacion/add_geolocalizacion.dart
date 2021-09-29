import 'dart:async';
import 'dart:ffi';

import 'package:app_comunic/app/domain/repositories/location_repository.dart';
import 'package:app_comunic/app/ui/globald_widgets/rounded_buttom_forms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

final Set<Marker> _markers = Set();

class MapLocation extends StatefulWidget {
  static const id = 'map-screem';
  const MapLocation({Key? key}) : super(key: key);

  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  Completer<GoogleMapController> _controller = Completer();
  String url = ""; //url imagen
  final formkey = GlobalKey<FormState>();
  TextEditingController Idtelefono = new TextEditingController();
  TextEditingController img = new TextEditingController();
  TextEditingController Modelo = new TextEditingController();
  TextEditingController Serie = new TextEditingController();
  late String imgurl;
  late String imgurls;

  final mapController = GoogleMapController;
  var locationMessage = '';
  String latitude = "";
  String longitude = "";

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  /*

  void initMarker(specify, specifyId) async {
    /*
    var marKerIdval = specifyId;
    final MarkerId markerId = MarkerId(marKerIdval);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['location'].latitude, specify['location'].longitude),
      infoWindow: InfoWindow(title: 'shp', snippet: specify['nombreSitio']),
    );
    setState(() {
      markers[markerId] = marker;
    });
    */
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    _markers.add(
      Marker(
        // markerId:MarkerId('newyork'),
        markerId: MarkerId('newyork'),
        position:
            LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(title: specify['nombreSitio']),
      ),
    );
    setState(() {
      markers[markerId] = markers as Marker;
    });
  }
  */

  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position:
          LatLng(specify['latitud'].latitude, specify['longitud'].longitude),
      // infoWindow: InfoWindow(title: specify['nombreSitio']),
      //  icon: Icon(Icons.directions_boat),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('newyork'),
        position: LatLng(
            (specify['latitud'].latitude), specify['longitud'].longitude),
      ),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    getmarker();
    super.initState();
  }

  getmarker() async {
    FirebaseFirestore.instance.collection('mark').get().then((mymockdata) {
      if (mymockdata.docs.isEmpty) {
        for (int i = 0; i < mymockdata.docs.length; i++) {
          initMarker(mymockdata.docs[i].data(), mymockdata.docs[i].id);
        }
      }
    });
  }

  updaDataimg() async {
    final postImageRef = FirebaseStorage.instance.ref().child("telefonos");
    var timekey = DateTime.now();
    // var taskupload =
    //    postImageRef.child(timekey.toString() + ".jpg").putFile(file!);
    //  UploadTask taslk = postImageRef.putFile(file!);
    //  TaskSnapshot snapshot = await taslk;
    //
    // url = await snapshot.ref.getDownloadURL();
    print("image url" + url);

    saveToDataBase(url);
  }

  Future<void> saveToDataBase(String url) async {
    var bdtimekey = DateTime.now();
    var formatdate = DateFormat('MMM d, yyyy');
    var formattime = DateFormat('EEEE, hh:mm aaa');
    String date = formatdate.format(bdtimekey);
    String time = formattime.format(bdtimekey);
    Map<String, dynamic> data = {
      "date": date,
      "time": time,
      "latitude": latitude,
      "longitude": longitude,
      "Idtelefono": Idtelefono.text,
      "Modelo": Modelo.text,
      "Serie": Serie.text,
      // "modelo": Modelo.text,
      "img": url
    };
    await FirebaseFirestore.instance.collection("Telefonos").add(data);
  }

  senData() async {
    if (formkey.currentState!.validate()) {
      // var StorageImage = FirebaseStorage.instance.ref().child(file!.path);
      // var task = StorageImage.putFile(file!);
      // imgurl = await (await task.snapshot).ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("telefonos").add({
        'idtelefono': Idtelefono.text,
        // 'img': imgurl.toString(),
        'Modelo': Modelo.text,
        'serie': Serie
      });
    }
  }

  // function for getting the current location
  // but before that you need to add this permission!
  void getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";
    //_currente = position;
    setState(() {
      //  locationMessage = "Latitude: $latitude and Longitude: $longitude";
    });
  }

  static final CameraPosition _ubicacionInicial = CameraPosition(
    target: LatLng(-12.116479, -77.034965),
    zoom: 14.4746,
    //-12.116479, -77.034965
  );

  static CameraPosition camPosicionUbicacion = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-12.116479, -77.034965),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          // TextField(),

          Container(
            height: 300.0,
            child: GoogleMap(
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: _ubicacionInicial,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          RoundedButtomForm(
            backgroundColor: Colors.purple,
            text: "Obtener Ubicacion",
            onPressed: () {
              _goToTheLake();
              getmarker();
              getCurrentLocation();
            },
          ),
          SizedBox(
            height: 30.0,
          ),

          Text(
            "Registrar Ubicacion",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),

          SizedBox(
            height: 05.0,
          ),
          const SizedBox(height: 10),

          // button for taking the location

          TextField(
              controller: Idtelefono,
              decoration: InputDecoration(hintText: 'Id_telefono')),
          SizedBox(height: 10),
          TextField(
              controller: Modelo,
              decoration: InputDecoration(hintText: 'Serie_Telefono')),
          SizedBox(height: 10),
          TextField(
              controller: Serie,
              decoration: InputDecoration(hintText: 'Modelo_Telefono')),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: updaDataimg,
        label: Text('Registrar!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

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
}
