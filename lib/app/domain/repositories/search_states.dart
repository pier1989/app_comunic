import 'package:app_comunic/app/data/data/search_model.dart';

abstract class SearchStates {}

class InitState extends SearchStates {}

class LoadingState extends SearchStates {}

class AddState extends SearchStates {}

class GetState extends SearchStates {
  List<SearchModel> emps;
  GetState({required this.emps});
}

class SearchState extends SearchStates {
  List<SearchModel> emps;
  SearchState({required this.emps});
}
