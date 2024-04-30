import 'dart:convert';

List<Tracking> trackingFromJson(String str) => List<Tracking>.from(json.decode(str).map((x) => Tracking.fromJson(x)));

String trackingToJson(List<Tracking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tracking {
  String rid;
  String rStatus;
  String hid;
  String donar;
  String volunteer;

  Tracking({
    required this.rid,
    required this.rStatus,
    required this.hid,
    required this.donar,
    required this.volunteer,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
    rid: json["RID"],
    rStatus: json["rStatus"],
    hid: json["HID"],
    donar: json["donar"],
    volunteer: json["volunteer"],
  );

  Map<String, dynamic> toJson() => {
    "RID": rid,
    "rStatus": rStatus,
    "HID": hid,
    "donar": donar,
    "volunteer": volunteer,
  };
}
