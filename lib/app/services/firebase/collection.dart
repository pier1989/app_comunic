import 'package:cloud_firestore/cloud_firestore.dart';

class Collection {
  // ignore: constant_identifier_names
  static const _MARK = 'mark';

  static Future<QuerySnapshot<Map<String, dynamic>>> getMarks() =>
      FirebaseFirestore.instance.collection(_MARK).get();
}
