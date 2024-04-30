import 'dart:convert';

List<FeedbackList> feedbackListFromJson(String str) => List<FeedbackList>.from(json.decode(str).map((x) => FeedbackList.fromJson(x)));

String feedbackListToJson(List<FeedbackList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackList {
  String id;
  String summary;
  DateTime date;
  String beneficiary;

  FeedbackList({
    required this.id,
    required this.summary,
    required this.date,
    required this.beneficiary,
  });

  factory FeedbackList.fromJson(Map<String, dynamic> json) => FeedbackList(
    id: json["ID"],
    summary: json["summary"],
    date: DateTime.parse(json["date"]),
    beneficiary: json["beneficiary"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "summary": summary,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "beneficiary": beneficiary,
  };
}
