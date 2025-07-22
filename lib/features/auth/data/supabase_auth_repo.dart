import 'package:admin/features/auth/domain/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepo implements AuthRepo {
  final supabaseAuth = Supabase.instance.client.auth;

  @override
  Future<bool> login(String email, String password) async {
    try {
      final authResponse = await supabaseAuth.signInWithPassword(
        email: email,
        password: password,
      );
      return authResponse.session != null;
    } catch (e) {
      throw Exception('Error signing in: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabaseAuth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  @override
  bool hasSession() => supabaseAuth.currentSession != null;
}
