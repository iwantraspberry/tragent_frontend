import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _user;
  bool _isLoading = false;
  String? _error;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  // Initialize auth state
  Future<void> initializeAuth() async {
    _setLoading(true);
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        _user = await _authService.getCurrentUser();
      }
      _clearError();
    } catch (e) {
      _setError('Failed to initialize authentication: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authService.login(email, password);
      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Login failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Register
  Future<bool> register(String email, String password, String name) async {
    _setLoading(true);
    try {
      _user = await _authService.register(email, password, name);
      _clearError();
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Registration failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Logout
  Future<void> logout() async {
    _setLoading(true);
    try {
      await _authService.logout();
      _user = null;
      _clearError();
    } catch (e) {
      _setError('Logout failed: $e');
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // Refresh user data
  Future<void> refreshUser() async {
    if (!isAuthenticated) return;
    
    try {
      _user = await _authService.getCurrentUser();
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Failed to refresh user data: $e');
    }
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
