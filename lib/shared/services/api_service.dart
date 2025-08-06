import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/travel_plan.dart';
import '../models/chat_message.dart';
import '../../core/constants/app_constants.dart';

class ApiService {
  static const String _baseUrl = AppConstants.apiBaseUrl;

  // Headers
  Map<String, String> _getHeaders({String? token}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Authentication
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: _getHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/register'),
      headers: _getHeaders(),
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Registration failed: ${response.body}');
    }
  }

  // User Profile
  Future<User> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/user/profile'),
      headers: _getHeaders(token: token),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get user profile: ${response.body}');
    }
  }

  // Travel Plans
  Future<List<TravelPlan>> getTravelPlans(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/travel/plans'),
      headers: _getHeaders(token: token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((plan) => TravelPlan.fromJson(plan)).toList();
    } else {
      throw Exception('Failed to get travel plans: ${response.body}');
    }
  }

  Future<TravelPlan> createTravelPlan(
    String token,
    Map<String, dynamic> planData,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/travel/plans'),
      headers: _getHeaders(token: token),
      body: jsonEncode(planData),
    );

    if (response.statusCode == 201) {
      return TravelPlan.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create travel plan: ${response.body}');
    }
  }

  // Destinations
  Future<List<TravelDestination>> searchDestinations(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/destinations/search?q=$query'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((dest) => TravelDestination.fromJson(dest)).toList();
    } else {
      throw Exception('Failed to search destinations: ${response.body}');
    }
  }

  Future<List<TravelDestination>> getPopularDestinations() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/destinations/popular'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((dest) => TravelDestination.fromJson(dest)).toList();
    } else {
      throw Exception('Failed to get popular destinations: ${response.body}');
    }
  }

  // Chat
  Future<ChatMessage> sendChatMessage(
    String token,
    String sessionId,
    String message,
  ) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/chat/sessions/$sessionId/messages'),
      headers: _getHeaders(token: token),
      body: jsonEncode({'content': message, 'type': 'text'}),
    );

    if (response.statusCode == 201) {
      return ChatMessage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message: ${response.body}');
    }
  }

  Future<List<ChatSession>> getChatSessions(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/chat/sessions'),
      headers: _getHeaders(token: token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((session) => ChatSession.fromJson(session)).toList();
    } else {
      throw Exception('Failed to get chat sessions: ${response.body}');
    }
  }

  Future<ChatSession> createChatSession(String token, String title) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/chat/sessions'),
      headers: _getHeaders(token: token),
      body: jsonEncode({'title': title}),
    );

    if (response.statusCode == 201) {
      return ChatSession.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create chat session: ${response.body}');
    }
  }
}
