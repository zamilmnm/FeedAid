import 'package:feed_aid_app/APIs/user/user.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUser(String url, String id, String user) async{
  final response = await http.post(Uri.parse(url), body: {
    "uId": id,
    "userType": user,
  });
  return userFromJson(response.body);
}