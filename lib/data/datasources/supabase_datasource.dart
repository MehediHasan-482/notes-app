import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDataSource {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    try {
      print('Login attempt for: $email');
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print('Login response received');
      print('Session: ${response.session != null}');
      print('User: ${response.user?.email}');

      if (response.session == null) {
        print('Session is null');
        throw Exception('Login failed');
      }
      print('Login successful');
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      print('Register attempt for: $email');

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
        print('User creation failed');
        throw Exception('Registration failed');
      }

      print('User created successfully');

      print('Auto logging in...');
      final signInResponse = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      print('Step 2 - SignIn Response:');
      print('Session: ${signInResponse.session != null}');

      if (signInResponse.session == null) {
        print('Auto-login failed - session null');
        throw Exception('Auto-login failed');
      }

      print('Registration and auto-login successful!');
    } catch (e) {
      print('Registration error: $e');
      print('Error type: ${e.runtimeType}');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      print('Logout attempt');
      await _client.auth.signOut();
      print('Logout successful');
    } catch (e) {
      print('Logout error: $e');
      rethrow;
    }
  }
  
  // Notes methods
  Future<List<Map<String, dynamic>>> getNotes() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');
    
    return await _client
        .from('notes')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
  }
  
  Future<void> addNote(String title, String description) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception('Not authenticated');
    
    await _client.from('notes').insert({
      'user_id': userId,
      'title': title,
      'description': description,
    });
  }
  
  Future<void> deleteNote(String noteId) async {
    await _client.from('notes').delete().eq('id', noteId);
  }
}
