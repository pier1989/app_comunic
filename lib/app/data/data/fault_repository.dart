import 'package:app_comunic/app/data/data/fault.dart';
import 'package:app_comunic/app/data/data/search_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FaultRepository {
  final CollectionReference _faults =
      FirebaseFirestore.instance.collection("averias");
  Future addFault(Fault fault) async {
    try {
      await _faults.add(fault.toMap());
    } catch (e) {
      print("Add Fault error: ${e.toString()}");
    }
  }

  Future updateState(int index, String state) async {
    try {
      var data = await _faults.get();
      var id = data.docs[index].id;
      await _faults.doc(id).update({"Estado": state});
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateFault(int index, Fault fault) async {
    try {
      var data = await _faults.get();
      var id = data.docs[index].id;
      await _faults.doc(id).update(fault.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Fault>> getFaults() async {
    try {
      var data = await _faults.get();
      var list = data.docs
          .map((fault) => Fault.fromMap(fault.data() as Map<String, dynamic>))
          .toList();
      return list;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<Fault> getFault(int index) async {
    Fault aux =
        Fault(date: "", detail: "", estado: "", img: "", name: "", time: "");
    try {
      var data = await _faults.get();
      var list = data.docs
          .map((fault) => Fault.fromMap(fault.data() as Map<String, dynamic>))
          .toList();
      return list[index];
    } catch (e) {
      print(e.toString());
      return aux;
    }
  }
}
