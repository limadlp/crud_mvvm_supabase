import 'package:crud_mvvm_supabase/app/services/auth/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthProvider implements AuthProvider {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @override
  Future<void> signUp(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      if (response.session == null) {
        throw Exception('Sign up failed');
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session == null) {
        throw Exception('Sign in failed');
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  bool isLoggedIn() {
    return _supabaseClient.auth.currentUser != null;
  }

  @override
  String? getCurrentUserEmail() {
    return _supabaseClient.auth.currentUser?.email;
  }
}
