class RequestClass {
  List<String> date;
  List<int> count;

  RequestClass({
    required this.date,
    required this.count,
  });

  factory RequestClass.fromJson(Map<String, dynamic> json) => RequestClass(
    date: List<String>.from(json["date"].map((x) => x)),
    count: List<int>.from(json["count"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": List<dynamic>.from(date.map((x) => x)),
    "count": List<dynamic>.from(count.map((x) => x)),
  };
}

class FoodClass {
  List<String> date;
  List<int> count;

  FoodClass({
    required this.date,
    required this.count,
  });

  factory FoodClass.fromJson(Map<String, dynamic> json) => FoodClass(
    date: List<String>.from(json["date"].map((x) => x)),
    count: List<int>.from(json["count"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "date": List<dynamic>.from(date.map((x) => x)),
    "count": List<dynamic>.from(count.map((x) => x)),
  };
}

