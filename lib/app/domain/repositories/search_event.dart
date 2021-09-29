abstract class SearchEvents {}

class AddEvent extends SearchEvents {
  String name;
  String details;
  AddEvent({required this.name, required this.details});
}

class GetAllEvent extends SearchEvents {}

class FindEvent extends SearchEvents {
  String key;
  FindEvent({required this.key});
}
