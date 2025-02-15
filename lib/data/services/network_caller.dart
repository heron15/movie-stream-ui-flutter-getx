import 'dart:convert';
import 'package:bd_calling_task/data/models/network_response_model.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  final Logger logger;

  NetworkCaller({required this.logger});

  Future<NetworkResponseModel> postRequest(String url, {Map<String, dynamic>? body}) async {
    try {
      _requestLog(url, {}, body ?? {}, '');

      Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Content-type': 'Application/json',
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _responseLog(url, response.statusCode, response.body, response.headers, true);

        final decodeData = json.decode(utf8.decode(response.bodyBytes));
        return NetworkResponseModel(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else {
        _responseLog(url, response.statusCode, response.body, response.headers, false);

        return NetworkResponseModel(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (error) {
      _responseLog(url, -1, null, {}, true, error);

      return NetworkResponseModel(
        statusCode: -1,
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<NetworkResponseModel> getRequest(String url) async {
    try {
      _requestLog(url, {}, {}, '');

      Response response = await get(
        Uri.parse(url),
        headers: {
          'Content-type': 'Application/json',
        },
      );

      if (response.statusCode == 200) {
        _responseLog(url, response.statusCode, response.body, response.headers, true);

        final decodeData = json.decode(utf8.decode(response.bodyBytes));
        return NetworkResponseModel(
          statusCode: response.statusCode,
          isSuccess: true,
          responseData: decodeData,
        );
      } else {
        _responseLog(url, response.statusCode, response.body, response.headers, false);

        return NetworkResponseModel(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (error) {
      _responseLog(url, -1, null, {}, true, error);

      return NetworkResponseModel(
        statusCode: -1,
        isSuccess: false,
        errorMessage: error.toString(),
      );
    }
  }

  void _requestLog(String url, Map<String, dynamic> params, Map<String, dynamic> body, String token) {
    logger.i('''
    Url: $url
    Params: $params
    Body: $body,
    Token: $token
    ''');
  }

  void _responseLog(String url, int statusCode, dynamic responseBody, Map<String, dynamic> headers, bool isSuccess,
      [dynamic error]) {
    String message = '''
    Url: $url
    Status Code: $statusCode
    Headers: $headers,
    Response Body: $responseBody,
    Error: $error,
    ''';
    if (isSuccess) {
      logger.i(message);
    } else {
      logger.e(message);
    }
  }
}
