import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'https://localhost:7144/api/Auth';
  Future<bool> login(String username, String password) async {

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "passwordHash": password,
        }),
      );

      print('Login status: ${response.statusCode}');
      print('Login body: ${response.body}');

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        print('userId in prefs: ${prefs.getInt('userId')}');

        await prefs.setString('jwt', body['token']);

        await prefs.setInt('userId', int.parse(body['userId'].toString()));

        await prefs.setString('username', body['username']);
        if (body['role'] != null) {
          await prefs.setString('role', body['role']?.toString() ?? 'User');
        }
        return true;
      }
      else {
        return false;
      }
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  /// Registers a new user
  Future<bool> register(String username, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "username": username,
        "passwordHash": password,
        "role": role,
      }),
    );

    return response.statusCode == 200;
  }

  /// Retrieves the stored JWT token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }

  /// Retrieves the stored user role
  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  /// Retrieves the logged-in username
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  /// Clears all stored session data (logout)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.remove('role');
    await prefs.remove('username');
  }
}
