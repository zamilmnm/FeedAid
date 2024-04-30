import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'homeDonation.dart';

Future<List<HomeDonation>> fetchAllDonations() async{
  var url = "$path/back_end/home/donation.php";
  final response = await http.get(Uri.parse(url));
  return homeDonationFromJson(response.body);
}