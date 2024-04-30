import 'dart:convert';

List<HomeBadge> homeBadgeFromJson(String str) => List<HomeBadge>.from(json.decode(str).map((x) => HomeBadge.fromJson(x)));

String homeBadgeToJson(List<HomeBadge> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeBadge {
  String food;
  String donor;
  String recipient;
  String request;

  HomeBadge({
    required this.food,
    required this.donor,
    required this.recipient,
    required this.request,
  });

  factory HomeBadge.fromJson(Map<String, dynamic> json) => HomeBadge(
    food: json["food"],
    donor: json["donor"],
    recipient: json["recipient"],
    request: json["request"],
  );

  Map<String, dynamic> toJson() => {
    "food": food,
    "donor": donor,
    "recipient": recipient,
    "request": request,
  };
}
