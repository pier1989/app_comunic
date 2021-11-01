class Fault {
  String estado;
  String date;
  String detail;
  String img;
  String name;
  String time;
  Fault({
    required this.estado,
    required this.date,
    required this.detail,
    required this.img,
    required this.name,
    required this.time,
  });
  toMap() => {
        "Estado": estado,
        "date": date,
        "detail": detail,
        "img": img,
        "name": name,
        "time": time
      };
  Fault.fromMap(Map<String, dynamic> map)
      : estado = map["Estado"],
        date = map["date"],
        detail = map["detail"],
        img = map["img"],
        name = map["name"],
        time = map["time"];
}