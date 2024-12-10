import 'auth_provider.dart';

class AuthService {
  final AuthProvider provider;

  AuthService(this.provider);

  Future<void> signUp(String email, String password) =>
      provider.signUp(email, password);
  Future<void> signIn(String email, String password) =>
      provider.signIn(email, password);
  Future<void> signOut() => provider.signOut();
  bool isLoggedIn() => provider.isLoggedIn();
  String? getCurrentUserEmail() => provider.getCurrentUserEmail();
}
