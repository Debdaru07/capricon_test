import 'package:dio/dio.dart';

class ApiClient {
  static const String _baseUrl = 'https://illuminate-production.up.railway.app';
  final Dio dio;

  ApiClient({String? token})
      : dio = Dio(BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token'
          },
        ));

  String get baseUrl => _baseUrl;
}