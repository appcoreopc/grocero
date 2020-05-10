import 'dart:convert';
import 'package:http/http.dart' as http;

class RestDataService {

  Future<List<T>> fetchData<T>(
      String targetUrl, String jsonTargetField) async {

    var result = List<T>();
    final response = await http.get(targetUrl);

    if (response.statusCode == 200) {
      var newscategories = json.decode(response.body);
      var articles = newscategories[jsonTargetField];
      for (var article in articles) {
        result.add(article);
      }
    }
    return result;
  }
}
