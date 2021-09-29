import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'list_averia/post.dart';

class MyApplist extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("students")
                  .add({"name": "Rajesh", "city": "Delhi"});
            },
          ),
          appBar: AppBar(
            title: Text("Firestore Demo"),
          ),
          body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("students").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    return ListTile(
                      title: Text(doc['name']),
                      subtitle: Text(doc['city']),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          doc.reference.delete();
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
