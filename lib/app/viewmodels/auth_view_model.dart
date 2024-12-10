import 'package:crud_mvvm_supabase/app/services/auth/auth_service.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService authService;

  AuthViewModel(this.authService);

  String _errorMessage = '';
  bool _isLoading = false;

  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      await authService.signIn(email, password);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp(String email, String password) async {
    _setLoading(true);
    try {
      await authService.signUp(email, password);
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    try {
      await authService.signOut();
    } catch (e) {
      _setError(e.toString());
    }
  }

  bool isLoggedIn() {
    return authService.isLoggedIn();
  }

  String? getCurrentUserEmail() {
    return authService.getCurrentUserEmail();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String value) {
    _errorMessage = value;
    notifyListeners();
  }
}
