import 'package:flutter/material.dart';
import '../../core/services/auth_service.dart';
import '../../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? user;
  bool isLoading = false;

  AuthViewModel() {
    _syncUser();
  }

  void _syncUser() {
    final firebaseUser = _authService.currentUser;

    if (firebaseUser != null) {
      user = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? '',
        photoUrl: firebaseUser.photoURL ?? '',
      );
    }

    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.signInWithGoogle();

      if (result?.user != null) { // ✅ SAFE FIX
        user = UserModel(
          uid: result!.user!.uid,
          email: result.user!.email ?? '',
          name: result.user!.displayName ?? '',
          photoUrl: result.user!.photoURL ?? '',
        );
      }
    } catch (e) {
      debugPrint("Auth Error: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.signOut();
    user = null;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;
}