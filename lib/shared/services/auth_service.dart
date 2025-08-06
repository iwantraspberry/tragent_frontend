import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../../core/constants/app_constants.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  
  // Get stored token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.tokenKey);
  }

  // Store token
  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.tokenKey, token);
  }

  // Store user ID
  Future<void> _storeUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.userIdKey, userId);
  }

  // Get stored user ID
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.userIdKey);
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Login
  Future<User> login(String email, String password) async {
    try {
      final response = await _apiService.login(email, password);
      final token = response['token'] as String;
      final userData = response['user'] as Map<String, dynamic>;
      
      await _storeToken(token);
      await _storeUserId(userData['id'] as String);
      
      return User.fromJson(userData);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Register
  Future<User> register(String email, String password, String name) async {
    try {
      final response = await _apiService.register(email, password, name);
      final token = response['token'] as String;
      final userData = response['user'] as Map<String, dynamic>;
      
      await _storeToken(token);
      await _storeUserId(userData['id'] as String);
      
      return User.fromJson(userData);
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    try {
      final token = await getToken();
      if (token == null) return null;
      
      return await _apiService.getUserProfile(token);
    } catch (e) {
      // If getting user fails, likely token is invalid
      await logout();
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userIdKey);
    await prefs.remove(AppConstants.userProfileKey);
    await prefs.remove(AppConstants.chatHistoryKey);
  }

  // Refresh token (if your backend supports it)
  Future<String?> refreshToken() async {
    // Implementation depends on your backend
    // This is a placeholder
    return await getToken();
  }
}
