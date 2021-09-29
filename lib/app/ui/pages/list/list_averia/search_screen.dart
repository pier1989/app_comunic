import 'package:app_comunic/app/data/data/search_repository.dart';
import 'package:app_comunic/app/domain/repositories/search_bloc.dart';
import 'package:app_comunic/app/domain/repositories/search_event.dart';
import 'package:app_comunic/app/domain/repositories/search_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchUi extends StatefulWidget {
  @override
  _SearchUiState createState() => _SearchUiState();
}

class _SearchUiState extends State<SearchUi> {
  late BlocProvider _blockProvidersearch;

  @override
  void initState() {
    Provider(
        create: (context) =>
            SearchBloc(InitState(), SearchRepository()).add(GetAllEvent()));

    //BlocProvider
    // BlocProvider.of<SearchBloc>(context).add(GetAllEvent());
    super.initState();
    _blockProvidersearch =
        context.read<SearchBloc>() as BlocProvider<BlocBase<Object?>>;
  }

  @override
  Widget build(BuildContext context) {
    // _blockProvidersearch<SearchBloc>(initialState, repo)
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(InitState(), SearchRepository()),
      child: Scaffold(
          body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(top: 50, right: 10, left: 10),
            child: TextField(
              onChanged: (value) {
                BlocProvider<SearchBloc>(
                  create: (context) {
                    return SearchBloc(InitState(), SearchRepository())
                      ..add(FindEvent(key: value));
                  },
                );

                //BlocProvider.of<SearchBloc>(context).add(FindEvent(key: value));
              },
              decoration: InputDecoration(
                hintText: "search ...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, size: 34, color: Colors.blue[700]),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Expanded(child: BlocBuilder<SearchBloc, SearchStates>(
            builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetState) {
                return ListView.builder(
                  itemCount: state.emps.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(state.emps[i].name),
                      subtitle: Text(state.emps[i].details),
                    );
                  },
                );
              } else if (state is SearchState) {
                return ListView.builder(
                  itemCount: state.emps.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(state.emps[i].name),
                      subtitle: Text(state.emps[i].details),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ))
        ],
      )),
    );
  }
}
