import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/models/user%20model/user_model.dart';
import 'package:foodapp/service/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final _repo = AuthRepository();

  UserModel? user;
  List<UserModel> users = [];
  bool isLoading = true;
  String? error;
  bool _isDisposed = false;

  StreamSubscription? usersSub;

  AuthProvider() {
    usersSub = _repo.watchUsers().listen((users) {
      if (users.isNotEmpty) {
        user = users[0];
        users.removeAt(0);
        this.users = users;
      } else {
        user = null;
        this.users = [];
      }
      _setLoading(false);
    });
  }

  /// 🔑 Login with email and password
  Future<void> login(String email, String password) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.login(email, password);
    } catch (e) {
      _setError('Login failed: $e');
      debugPrint('Login error: $e');
      _setLoading(false);
    }
  }

  /// 📝 Register new user
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    String role = 'user',
    String? imageUrl,
  }) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.register(
        name: name,
        email: email,
        password: password,
        role: role,
        phoneNumber: phoneNumber,
        imageUrl: imageUrl,
      );
    } catch (e) {
      _setError('Registration failed: $e');
      debugPrint('Register error: $e');
      _setLoading(false);
      rethrow;
    }
  }

  /// 🚪 Logout user
  Future<void> logout() async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.logout();
    } catch (e) {
      _setError('Logout failed: $e');
      debugPrint('Logout error: $e');
      _setLoading(false);
    }
  }

  /// ✏️ Update user profile
  Future<void> updateProfile(
    String userId, {
    bool? buyingPoints,
    String? name,
    String? phoneNumber,
    String? address,
    String? imageUrl,
    bool? blocked,
  }) async {
    try {
      _setError(null);
      _setLoading(true);
      int? points = buyingPoints != null
          ? (buyingPoints
                ? users
                          .firstWhere((user) => user.authID == userId)
                          .buyingPoints +
                      5
                : users
                          .firstWhere((user) => user.authID == userId)
                          .buyingPoints -
                      5)
          : null;
      await _repo.updateProfile(
        userId,
        buyingPoints: points,
        name: name,
        phoneNumber: phoneNumber,
        address: address,
        imageUrl: imageUrl,
        blocked: blocked,
      );
    } catch (e) {
      _setError('Update failed: $e');
      debugPrint('Update profile error: $e');
      _setLoading(false);
    }
  }

  /// 📥 Fetch all users except current
  Future<void> fetchAllUsers() async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.fetchAllUsers();
    } catch (e) {
      _setError('Failed to fetch users: $e');
      debugPrint('Fetch all users error: $e');
      _setLoading(false);
    }
  }

  /// Change another user's role (admin only)
  Future<void> changeUserRole(String userAuthId, String newRole) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.updateUserRole(userAuthId, newRole);
    } catch (e) {
      _setError('Failed to change user role: $e');
      debugPrint('Change user role error: $e');
      _setLoading(false);
      rethrow;
    }
  }

  /// 🔧 Helper to safely set loading state
  void _setLoading(bool value) {
    if (!_isDisposed) {
      isLoading = value;
      notifyListeners();
    }
  }

  /// 🔧 Helper to safely set error state
  void _setError(String? value) {
    if (!_isDisposed) {
      error = value;
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
