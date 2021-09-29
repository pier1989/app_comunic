import 'package:app_comunic/app/data/data/search_repository.dart';
import 'package:app_comunic/app/domain/repositories/search_bloc.dart';
import 'package:app_comunic/app/domain/repositories/search_event.dart';
import 'package:app_comunic/app/domain/repositories/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'list_averia/search_screen.dart';

class Insert extends StatefulWidget {
  @override
  InsertState createState() => InsertState();
}

class InsertState extends State<Insert> {
  final SearchBloc _searchBloc = SearchBloc(InitState(), SearchRepository());

  var name = TextEditingController();
  var details = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(InitState(), SearchRepository()),
      child: Scaffold(
          body: BlocListener<SearchBloc, SearchStates>(
        listener: (context, state) {
          if (state is AddState) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchUi()));
          }
        },
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    hintText: "name",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                child: TextField(
                  controller: details,
                  decoration: InputDecoration(
                    hintText: "details",
                  ),
                ),
              ),
              Container(
                  child: RaisedButton(
                child: Text("Insert"),
                onPressed: () {
                  /*
                  Provider(
                      create: (context) =>
                          SearchBloc(InitState(), SearchRepository()).add(
                              AddEvent(
                                  name: name.text, details: details.text)));
                                  */
                  BlocProvider<SearchBloc>(
                    create: (context) {
                      return SearchBloc(InitState(), SearchRepository())
                        ..add(AddEvent(name: name.text, details: details.text));
                    },
                  );
                  //  .add(AddEvent(name: name.text, details: details.text));
                },
              )),
            ],
          ),
        ),
      )),
    );
  }
}
