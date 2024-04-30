import 'dart:convert';

List<HomeRequest> homeRequestFromJson(String str) => List<HomeRequest>.from(json.decode(str).map((x) => HomeRequest.fromJson(x)));

String homeRequestToJson(List<HomeRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeRequest {
  String id;
  DateTime date;
  String rCount;
  String fName;
  String fImage;

  HomeRequest({
    required this.id,
    required this.date,
    required this.rCount,
    required this.fName,
    required this.fImage,
  });

  factory HomeRequest.fromJson(Map<String, dynamic> json) => HomeRequest(
    id: json["ID"],
    date: DateTime.parse(json["date"]),
    rCount: json["rCount"],
    fName: json["F_name"],
    fImage: json["F_image"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "rCount": rCount,
    "F_name": fName,
    "F_image": fImage,
  };
}
