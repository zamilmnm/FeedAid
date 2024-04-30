import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'homeRequest.dart';

Future<List<HomeRequest>> fetchAllRequests() async{
  var url = "$path/back_end/home/request.php";
  final response = await http.get(Uri.parse(url));
  return homeRequestFromJson(response.body);
}

Future<List<HomeRequest>> fetchSpecificRequests(String bID) async{
  var url = "$path/back_end/home/view.php";
  final response = await http.post(Uri.parse(url), body: {
    'bID': bID
  });
  return homeRequestFromJson(response.body);
}