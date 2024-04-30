import 'dart:convert';

List<HomeDonation> homeDonationFromJson(String str) => List<HomeDonation>.from(json.decode(str).map((x) => HomeDonation.fromJson(x)));

String homeDonationToJson(List<HomeDonation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeDonation {
  String id;
  DateTime date;
  String rCount;
  String food;
  String location;

  HomeDonation({
    required this.id,
    required this.date,
    required this.rCount,
    required this.food,
    required this.location,
  });

  factory HomeDonation.fromJson(Map<String, dynamic> json) => HomeDonation(
    id: json["ID"],
    date: DateTime.parse(json["date"]),
    rCount: json["rCount"],
    food: json["food"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "rCount": rCount,
    "food": food,
    "location": location,
  };
}
