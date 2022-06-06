import 'package:http/http.dart' as http;

class ApiService {
  static final client = http.Client();
  static String baseUrl = "http://insta-api.test/api/";
}
