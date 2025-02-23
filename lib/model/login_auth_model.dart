import 'package:dio/dio.dart';
import '../core/api_client.dart';
import 'auth_model.dart';

class LoginAuth {
  final String identifier;
  final String password;
  final ApiClient _apiClient;

  LoginAuth({
    required this.identifier,
    required this.password,
    ApiClient? apiClient,
  }) : _apiClient = apiClient ?? ApiClient(); 

  factory LoginAuth.fromJson(Map<String, dynamic> json) {
    return LoginAuth(
      identifier: json['identifier'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'password': password,
    };
  }

  Future<AuthResponse> login() async {
    try {
      final response = await _apiClient.dio.post(
        '/api/auth/local',
        data: toJson(),
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('Login failed: ${e.response?.data['error'] ?? e.message}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}