import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  User? _user;
  bool _isLoading = false;
  String? _error;
  bool _isGuestMode = false;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null && !_isGuestMode;
  bool get isGuestMode => _isGuestMode;
  bool get isLoggedIn => _user != null;

  // Initialize auth state
  Future<void> initializeAuth() async {
    _setLoading(true);
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        _user = await _authService.getCurrentUser();
        _isGuestMode = false;
      } else {
        // Start in guest mode
        _enableGuestMode();
      }
      _clearError();
    } catch (e) {
      _setError('Failed to initialize authentication: $e');
      _enableGuestMode(); // Fallback to guest mode
    } finally {
      _setLoading(false);
    }
  }

  // Enable guest mode
  void _enableGuestMode() {
    _isGuestMode = true;
    _user = User(
      id: 'guest',
      email: 'guest@example.com',
      name: 'Guest User',
      createdAt: DateTime.now(),
    );
    notifyListeners();
  }

  // Continue as guest
  void continueAsGuest() {
    _enableGuestMode();
  }

  // Login
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      _user = await _authService.login(email, password);
      _isGuestMode = false;
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
      _isGuestMode = false;
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
      if (!_isGuestMode) {
        await _authService.logout();
      }
      _enableGuestMode(); // Switch back to guest mode
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
    if (!isLoggedIn || _isGuestMode) return;

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
