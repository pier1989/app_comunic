import 'package:app_comunic/app/data/data/search_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:instantsearchbloc/data/search_model.dart';

// instancia BASE DE DATOS
class SearchRepository {
  var db = FirebaseFirestore.instance.collection("empl");

  addEmp(SearchModel emp) {
    db.add(emp.toMap());
  }

  Future<List<SearchModel>> getEmp() async {
    var data = await db.get();
    var emps = data.docs.map((emp) => SearchModel.fromMap(emp.data())).toList();
    return emps;
  }

  Future<List<SearchModel>> findEmp(key) async {
    var data = await db.where('key', arrayContains: key).get();
    var emps = data.docs.map((emp) => SearchModel.fromMap(emp.data())).toList();
    return emps;
  }
}
