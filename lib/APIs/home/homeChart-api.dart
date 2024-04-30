import 'dart:convert';
import '../../constants.dart';
import 'homeChart.dart';
import 'package:http/http.dart' as http;

List<RequestClass> fromJson(String strJson){
  final data = jsonDecode(strJson);
  return List<RequestClass>.from(data.map((i) => RequestClass.fromJson(i)));
}

Future<List<RequestClass>> getRequestData() async{
  List<RequestClass> requestList = [];
  var url = "$path/back_end/home/requestChart.php";
  final response = await http.post(Uri.parse(url));
  if(response.statusCode == 200){
    return requestList = fromJson(response.body);
  }
  return requestList;
}

Future<List<RequestClass>> getRequestSpecificData(String stDate, String enDate) async{
  List<RequestClass> requestList = [];
  var url = "$path/back_end/home/specificDateRequestChart.php";
  final response = await http.post(Uri.parse(url), body: {
    'enDate': enDate,
    'stDate': stDate,
  });
  if(response.statusCode == 200){
    return requestList = fromJson(response.body);
  }
  return requestList;
}

List<FoodClass> fFromJson(String strJson){
  final data = jsonDecode(strJson);
  return List<FoodClass>.from(data.map((i) => FoodClass.fromJson(i)));
}

Future<List<FoodClass>> getFoodData() async{
  List<FoodClass> requestList = [];
  var url = "$path/back_end/home/foodChart.php";
  final response = await http.post(Uri.parse(url));
  if(response.statusCode == 200){
    return requestList = fFromJson(response.body);
  }
  return requestList;
}

Future<List<FoodClass>> getFoodSpecificData(String stDate, String enDate) async{
  List<FoodClass> requestList = [];
  var url = "$path/back_end/home/specificDateFoodChart.php";
  final response = await http.post(Uri.parse(url), body: {
    'enDate': enDate,
    'stDate': stDate,
  });
  if(response.statusCode == 200){
    return requestList = fFromJson(response.body);
  }
  return requestList;
}