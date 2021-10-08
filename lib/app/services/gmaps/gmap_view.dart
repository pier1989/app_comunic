import 'package:app_comunic/app/services/firebase/collection.dart';
import 'package:app_comunic/app/services/firebase/models.dart';
import 'package:app_comunic/app/services/gmaps/gmap_markers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static const historyLength = 5;
  final _searchHistory = <String>[];
  var filteredSearchHistory = <String>[];
  String selectedTerm = '';
  final controller = FloatingSearchBarController();

  MyValues? selected;

  var markers = <MarkerId, Marker>{};
  var allValues = <MyValues>[];

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }

    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  getMarkerData() async {
    final collection = await Collection.getMarks();

    if (collection.docs.isNotEmpty) {
      for (final fb in collection.docs) {
        final value = MyValues.fromMap(fb.data());
        final marker = value.getMarker();
        markers[value.getMarkerID()] = marker;
        addSearchTerm(value.phone.toString());
        allValues.add(value);
      }
    }
    setState(() {});
  }

  void foundByQuery(String phoneQuery) {
    final isMarker =
        allValues.map((e) => e.phone).any((e) => e.toString() == phoneQuery);

    if (isMarker) {
      final marker =
          allValues.firstWhere((e) => e.phone.toString() == phoneQuery);

      setState(() {
        selected = marker;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getMarkerData();
    filteredSearchHistory = filterSearchTerms(filter: '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FloatingSearchBar(
        controller: controller,
        isScrollControlled: true,
        body: FloatingSearchBarScrollNotifier(
          child: GMapMarkers(markers: markers, selected: selected),
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: const BouncingScrollPhysics(),
        title: Text(
          'Search Phones',
          style: Theme.of(context).textTheme.headline6,
        ),
        hint: 'Search and find out...',
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          foundByQuery(query);
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Start searching',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        foundByQuery(controller.query);
                        controller.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.phone),
                              onTap: () {
                                foundByQuery(term);

                                controller.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
