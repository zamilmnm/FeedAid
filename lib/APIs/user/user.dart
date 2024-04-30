import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String uId;
  String uName;
  String uAddress;
  String uContact;
  String uEmail;
  String uPassword;

  User({
    required this.uId,
    required this.uName,
    required this.uAddress,
    required this.uContact,
    required this.uEmail,
    required this.uPassword,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uId: json["uID"],
    uName: json["uName"],
    uAddress: json["uAddress"],
    uContact: json["uContact"],
    uEmail: json["uEmail"],
    uPassword: json["uPassword"],
  );

  Map<String, dynamic> toJson() => {
    "uID": uId,
    "uName": uName,
    "uAddress": uAddress,
    "uContact": uContact,
    "uEmail": uEmail,
    "uPassword": uPassword,
  };
}
