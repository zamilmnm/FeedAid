import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'homeBadge.dart';

Future<List<HomeBadge>> fetchBadge() async{
  var url = "$path/back_end/home/badge.php";
  final response = await http.get(Uri.parse(url));
  return homeBadgeFromJson(response.body);
}