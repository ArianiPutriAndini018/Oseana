import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      await _client.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
        },
      );
    } on AuthException catch (e) {
      throw Exception(_mapAuthException(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan yang tidak terduga. Silakan coba lagi.');
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      throw Exception(_mapAuthException(e));
    } catch (e) {
      throw Exception('Terjadi kesalahan yang tidak terduga. Silakan coba lagi.');
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw Exception('Gagal keluar. Silakan coba lagi.');
    }
  }

  String _mapAuthException(AuthException e) {
    switch (e.message.toLowerCase()) {
      case 'invalid login credentials':
      case 'invalid_credentials':
        return 'Email atau password salah.';
      case 'user already registered':
        return 'Email ini sudah terdaftar.';
      case 'password should be at least 6 characters':
        return 'Password harus minimal 6 karakter.';
      default:
        return 'Gagal memproses autentikasi. Silakan periksa koneksi Anda.';
    }
  }
}
