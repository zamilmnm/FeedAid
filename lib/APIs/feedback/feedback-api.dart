import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'feedback.dart';

Future<List<FeedbackList>> fetchFeedback() async {
  var url = "$path/back_end/feedback/view.php";

  final response = await http.get(Uri.parse(url));

  return feedbackListFromJson(response.body);
}