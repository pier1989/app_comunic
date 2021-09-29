//import 'dart:html';

import 'dart:math';

import 'package:app_comunic/app/ui/globald_widgets/custom_imput_field.dart';
import 'package:app_comunic/app/ui/globald_widgets/rounded_buttom_forms.dart';
import 'package:app_comunic/app/ui/globald_widgets/rounded_button.dart';
import 'package:app_comunic/app/ui/pages/navigation_drawer/controler/item_image_menu.dart';
import 'package:app_comunic/app/utils/name_validator.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/flutter_meedu.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class RegisterTelefono extends StatefulWidget {
  @override
  _CustomScrollViewComponentState createState() =>
      _CustomScrollViewComponentState();
}

class _CustomScrollViewComponentState extends State<RegisterTelefono> {
  File? file;
  String url = ""; //url imagen
  // late String _myvalue;
  //variables

  final formkey = GlobalKey<FormState>();
  TextEditingController Idtelefono = new TextEditingController();
  TextEditingController img = new TextEditingController();
  TextEditingController Modelo = new TextEditingController();
  TextEditingController Serie = new TextEditingController();
  late String imgurl;
  late String imgurls;
  updaDataimg() async {
    final postImageRef = FirebaseStorage.instance.ref().child("telefonos");
    var timekey = DateTime.now();
    var taskupload =
        postImageRef.child(timekey.toString() + ".jpg").putFile(file!);
    UploadTask taslk = postImageRef.putFile(file!);
    TaskSnapshot snapshot = await taslk;
    //
    url = await snapshot.ref.getDownloadURL();
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
      "Idtelefono": Idtelefono.text,
      "Modelo": Modelo.text,
      "Serie": Serie.text,
      // "modelo": Modelo.text,
      "img": url
    };
    await FirebaseFirestore.instance.collection("Telefonos").add(data);

    /*
   await FirebaseFirestore.instance.collection("averias").doc().set({
      "img": url,
      data,
      "date": date,
      "time": time,
      "averia": name,
      "descripcion": detail
    });*/
  }

  senData() async {
    if (formkey.currentState!.validate()) {
      var StorageImage = FirebaseStorage.instance.ref().child(file!.path);
      var task = StorageImage.putFile(file!);
      imgurl = await (await task.snapshot).ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("telefonos").add({
        'idtelefono': Idtelefono.text,
        'img': imgurl.toString(),
        'Modelo': Modelo.text,
        'serie': Serie
      });
    }
  }

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      file = File(image!.path);
      // image = img as XFile?;
      //print('Image Path $image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                //bottom: MediaQuery.of(context).size.height,
                child: Image.asset(
                  "assets/images/dark/fondis.jpg",
                ),
              ),
              Positioned(
                top: 100,
                left: 32,
                child: Text(
                  'Registrar Telefono',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Positioned(
                top: 190,
                child: Container(
                  padding: EdgeInsets.all(32),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(62),
                          topRight: Radius.circular(62))),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Positioned(

                              // top: expandedHeight / 1.7 - shrinkOffset,
                              left: MediaQuery.of(context).size.width / 3.5,
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 4.3,
                                backgroundColor: Colors.yellow,
                                child: InkWell(
                                  onTap: () {
                                    // senData();
                                  },
                                  child: CircleAvatar(
                                    radius:
                                        MediaQuery.of(context).size.width / 4.6,
                                    backgroundImage: file == null
                                        ? AssetImage(
                                            "assets/images/dark/fodofoto.png")
                                        : FileImage(File(file!.path))
                                            as ImageProvider,
                                    //NetworkImage(
                                    //'https://pm1.narvii.com/7219/b493e34427e645f3fb82d09f2185a177d9230392r1-466-658v2_00.jpg'
                                    //),
                                  ),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.camera,
                                size: 30.0,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                          ),
                        ],
                      ),
                      TextField(
                          controller: Idtelefono,
                          decoration: InputDecoration(hintText: 'Id_telefono')),
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 42),
                        child: TextField(
                          controller: Modelo,
                          decoration:
                              InputDecoration(hintText: 'Serie_Telefono'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16, bottom: 42),
                        child: TextField(
                          controller: Serie,
                          decoration:
                              InputDecoration(hintText: 'Modelo_Telefono'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      RoundedButtomForm(
                        backgroundColor: Colors.purple,
                        text: "Registrar",
                        onPressed: updaDataimg,

                        //ValidateAndSave,

                        //=> sendLoginForm(context),
                      ),
                      Container(
                        height: 8,
                      ),
                      Text(
                        "Forgot your Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        height: 70,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Center(
                              child: Icon(
                                Icons.face,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Container(
                            width: 30,
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: Center(
                              child: Icon(
                                Icons.fingerprint,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void uploadStatusImage() {
//final StorageReference postImageref = FirebaseStorage.instance.ref()
}
