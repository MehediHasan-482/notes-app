import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDataSource {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    try {
      print('🔐 Login attempt for: $email');
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print('✅ Login response received');
      print('Session: ${response.session != null}');
      print('User: ${response.user?.email}');

      if (response.session == null) {
        print('❌ Session is null');
        throw Exception('Login failed');
      }
      print('✅ Login successful');
    } catch (e) {
      print('❌ Login error: $e');
      rethrow;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print('📝 Register attempt for: $email');

      // Step 1: Sign up
      final signUpResponse = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
        emailRedirectTo: null,
      );

      print('Step 1 - SignUp Response:');
      print('User: ${signUpResponse.user?.email}');
      print('Session: ${signUpResponse.session != null}');

      if (signUpResponse.user == null) {
        print('❌ User creation failed');
        throw Exception('Registration failed');
      }

      print('✅ User created successfully');

      // Step 2: Auto login
      print('🔐 Auto logging in...');
      final signInResponse = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      print('Step 2 - SignIn Response:');
      print('Session: ${signInResponse.session != null}');

      if (signInResponse.session == null) {
        print('❌ Auto-login failed - session null');
        throw Exception('Auto-login failed');
      }

      print('✅ Registration and auto-login successful!');
    } catch (e) {
      print('❌ Registration error: $e');
      print('Error type: ${e.runtimeType}');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      print('👋 Logout attempt');
      await _client.auth.signOut();
      print('✅ Logout successful');
    } catch (e) {
      print('❌ Logout error: $e');
      rethrow;
    }
  }
}
