import '../../constants.dart';
import 'homePrediction.dart';
import 'package:http/http.dart' as http;

Future<List<Prediction>> showPrediction() async{
  var url = "$path/back_end/home/prediction.php";
  final response = await http.get(Uri.parse(url));
  return predictionFromJson(response.body);
}