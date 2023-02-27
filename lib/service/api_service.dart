import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "https://www.butomy.com";
  getData(endUrl) {
    var url = baseUrl + endUrl;
    var response = http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    });

    return response;
  }
}
