import 'dart:convert';

List<Food> foodFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
  String fId;
  String fName;
  String fImage;
  String fCount;
  String ftIdFk;

  Food({
    required this.fId,
    required this.fName,
    required this.fImage,
    required this.fCount,
    required this.ftIdFk,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    fId: json["F_id"],
    fName: json["F_name"],
    fImage: json["F_image"],
    fCount: json["F_count"],
    ftIdFk: json["FT_id_fk"],
  );

  Map<String, dynamic> toJson() => {
    "F_id": fId,
    "F_name": fName,
    "F_image": fImage,
    "F_count": fCount,
    "FT_id_fk": ftIdFk,
  };
}
