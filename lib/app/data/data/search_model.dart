class SearchModel {
  String name;
  String details;
  late List<String> key;

  SearchModel({required this.name, required this.details, required this.key});

  toMap() => {
        "name": name,
        "details": details,
        "key": key,
      };

  SearchModel.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        details = map["details"];
}
