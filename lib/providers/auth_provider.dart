import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  Student? _student;
  bool _isLoading = false;
  String? _error;

  Student? get student => _student;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _student != null;
  String? get error => _error;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      apiService.setToken(token);
      await fetchCurrentStudent();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.post('/auth/login', body: {
        'email': email,
        'password': password,
      });

      if (response['success'] == true) {
        final data = response['data'];
        final token = data['token'];
        _student = Student.fromJson(data['user']);

        apiService.setToken(token);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        _isLoading = false;
        notifyListeners();
        return true;
      }
    } on ApiException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'Không thể kết nối đến server';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> fetchCurrentStudent() async {
    try {
      final response = await apiService.get('/auth/me');
      if (response['success'] == true) {
        _student = Student.fromJson(response['data']);
        notifyListeners();
      }
    } catch (e) {
      await logout();
    }
  }

  Future<void> logout() async {
    _student = null;
    apiService.setToken(null);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    notifyListeners();
  }

  Future<bool> register({
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.post('/auth/register', body: {
        'email': email,
        'password': password,
        'full_name': fullName,
        if (phoneNumber != null) 'phone_number': phoneNumber,
      });

      _isLoading = false;
      notifyListeners();
      return response['success'] == true;
    } on ApiException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'Không thể kết nối đến server';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
