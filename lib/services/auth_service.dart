import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/models/user_model.dart';
import 'api_service.dart';

class AuthService extends ChangeNotifier {
  UserModel? _user;
  String? _token;
  bool _isLoading = false;

  UserModel? get user => _user;
  String? get token => _token;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _token != null;

  AuthService() {
    _loadAuthData();
  }

  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    final userJson = prefs.getString('user_data');
    if (userJson != null) {
      try {
        _user = UserModel.fromJson(jsonDecode(userJson));
      } catch (e) {
        debugPrint('Error decoding user data: $e');
      }
    }
    notifyListeners();
    
    // Refresh user data from API if token exists
    if (_token != null) {
      refreshUser();
    }
  }

  Future<void> refreshUser() async {
    try {
      final response = await ApiService.get('/user');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          _user = UserModel.fromJson(data['data']);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_data', jsonEncode(_user!.toJson()));
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('Error refreshing user: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.post('/login', {
        'email': email,
        'password': password,
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _token = data['data']['token'];
        _user = UserModel.fromJson(data['data']['user']);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        await prefs.setString('user_data', jsonEncode(_user!.toJson()));
        
        _isLoading = false;
        notifyListeners();
        return {'success': true, 'message': data['message']};
      } else {
        _isLoading = false;
        notifyListeners();
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Terjadi kesalahan koneksi: $e'};
    }
  }

  Future<Map<String, dynamic>> register(String nama, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.post('/register', {
        'nama': nama,
        'email': email,
        'password': password,
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _token = data['data']['token'];
        _user = UserModel.fromJson(data['data']['user']);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        await prefs.setString('user_data', jsonEncode(_user!.toJson()));
        
        _isLoading = false;
        notifyListeners();
        return {'success': true, 'message': data['message']};
      } else {
        _isLoading = false;
        notifyListeners();
        return {'success': false, 'message': data['message'] ?? 'Registration failed'};
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Terjadi kesalahan koneksi: $e'};
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String nama,
    String? noTelp,
    String? fotoProfil,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.post('/user/update', {
        'nama': nama,
        'no_telp': noTelp,
        'foto_profil': fotoProfil,
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _user = UserModel.fromJson(data['data']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', jsonEncode(_user!.toJson()));
        
        _isLoading = false;
        notifyListeners();
        return {'success': true, 'message': data['message']};
      } else {
        _isLoading = false;
        notifyListeners();
        return {'success': false, 'message': data['message'] ?? 'Update failed'};
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Terjadi kesalahan koneksi: $e'};
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.post('/user/change-password', {
        'current_password': currentPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      });

      final data = jsonDecode(response.body);

      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200 && data['success'] == true) {
        return {'success': true, 'message': data['message']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Password change failed'};
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': 'Terjadi kesalahan koneksi: $e'};
    }
  }

  Future<void> logout() async {
    try {
      // Send request to API to revoke token
      await ApiService.post('/logout', {});
    } catch (e) {
      debugPrint('Error during logout: $e');
    } finally {
      // Always clear local data even if API call fails
      _token = null;
      _user = null;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('user_data');
      notifyListeners();
    }
  }
}
