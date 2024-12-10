abstract class AuthProvider {
  Future<void> signUp(String email, String password);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
  bool isLoggedIn();
  String? getCurrentUserEmail();
}
