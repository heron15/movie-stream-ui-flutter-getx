import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static final String _baseUrl = dotenv.env['BASE_URL']!;

  // Public APIs
  static String getDownloads = "$_baseUrl/posts";
}
