 import 'dart:convert';

import 'package:http/http.dart' as http;

import '../error/exception.dart';

abstract class ApiClient {
  Future <dynamic> get(
      String url, {
        Map<String, String>? headers,
        Map<String, dynamic>? queryParameters,
      });

  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });

  Future<dynamic> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  });
}

class ApiClientImpl implements ApiClient {
  final http.Client _client;
  ApiClientImpl(this._client);

  Map<String, String> _getHeaders (Map<String, String>? extraHeaders){
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      ...?extraHeaders
    };
  }
  dynamic _handleResponse(http.Response response) {
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        throw ServerException('Failed to parse JSON');
      }
    } else {
      try {
        final errorBody = jsonDecode(response.body);
        throw ServerException(errorBody['message']??'Something went wrong ${response.statusCode}');
        } catch (e) {
        throw ServerException('Failed to parse JSON ${response.statusCode}');
      }
    }
  }

  @override
  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParameters);
    final response = await _client.get(uri, headers: _getHeaders(headers),);
    return _handleResponse(response);
  }
  @override
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    Object? body
    }) async{
    final uri = Uri.parse(url);
    print("jsonEncode(body)================${jsonEncode(body)}");
    final response = await _client.post(
        uri, headers: _getHeaders(headers), body: jsonEncode(body));
    return _handleResponse(response);
  }

  @override
  Future<dynamic> delete(
      String url, {
        Map<String, String>? headers,
        Map<String, dynamic>? queryParameters,
      }) async {
    final uri = Uri.parse(url).replace(queryParameters: queryParameters);
    final response = await _client.delete(uri, headers: _getHeaders(headers),);
    return _handleResponse(response);
  }
}