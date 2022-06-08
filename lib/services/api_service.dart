import 'package:http/http.dart' as http;

class ApiService {
  static final client = http.Client();
  static String baseUrl = "http://192.168.0.11:8000/api/";
  static String realUrl = "http://192.168.0.11:8000/";
}
