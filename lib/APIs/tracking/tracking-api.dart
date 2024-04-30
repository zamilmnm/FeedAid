import 'package:feed_aid_app/APIs/tracking/tracking.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';

Future<List<Tracking>> fetchTracking() async {

  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();

  var url = "$path/back_end/tracking/view.php";

  final response = await http.post(Uri.parse(url), body: {
    'beneficiary': sharedPreferences.getString('uId').toString(),
    'rID': sharedPreferences.getString('rId').toString()
  });

  return trackingFromJson(response.body);
}