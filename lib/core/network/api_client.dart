 import 'dart:convert';
import 'dart:io';

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
  Future<dynamic> patch(
    String url, {
    Map<String, String>? headers,
    Object? body,
  });
  Future<dynamic> postWithFile(
    String url, {
    Map<String, String>? headers,
    Object? body,
    File? file,
    String fileField = 'file',
    Map<String, String>? fields,
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
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        if (response.body.isEmpty) {
          return null;
        }
        return jsonDecode(response.body);
      } catch (e) {
        throw ServerException('Failed to parse JSON $e');
      }
    } else {
      try {
        final errorBody = jsonDecode(response.body);
        throw ServerException(errorBody['message']??'Something went wrong ${response.statusCode}');
        } catch (e) {
        print(response.body);
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
    final response = await _client.post(
        uri, headers: _getHeaders(headers), body: jsonEncode(body));
    return _handleResponse(response);
  }

  @override
  Future<dynamic> patch(
    String url, {
    Map<String, String>? headers,
    Object? body
    }) async{
    final uri = Uri.parse(url);
    final response = await _client.patch(
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

  @override
  Future<dynamic> postWithFile(
      String url, {Map<String, String>? headers, Object? body,
        File? file,
        String fileField = 'file',
        Map<String, String>? fields,
      }) async{
    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);

    // headers
    request.headers.addAll({
      'Accept': 'application/json',
      ...?headers,
    });

    if (fields != null) {
      request.fields.addAll(fields);
    }
    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          fileField,
          file.path,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return _handleResponse(response);
  }
}