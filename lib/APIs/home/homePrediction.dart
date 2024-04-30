import 'dart:convert';

List<Prediction> predictionFromJson(String str) => List<Prediction>.from(json.decode(str).map((x) => Prediction.fromJson(x)));

String predictionToJson(List<Prediction> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Prediction {
  String request;
  String food;
  List<String> increse;
  List<String> decrese;

  Prediction({
    required this.request,
    required this.food,
    required this.increse,
    required this.decrese,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    request: json["request"],
    food: json["food"],
    increse: List<String>.from(json["increse"].map((x) => x)),
    decrese: List<String>.from(json["decrese"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "request": request,
    "food": food,
    "increse": List<dynamic>.from(increse.map((x) => x)),
    "decrese": List<dynamic>.from(decrese.map((x) => x)),
  };
}
