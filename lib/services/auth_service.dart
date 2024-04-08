import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:email_validator_flutter/email_validator_flutter.dart';

class AuthService {
  final String username;
  final String email;
  final String password;

  AuthService({
    this.username = '',
    required this.email,
    required this.password,
  });
  final supabase = Supabase.instance.client;
  Future<int> signUp() async {
    try {
      final data =
          await supabase.from('user_info').select().eq('username', username);
      if (data.isEmpty) {
        final AuthResponse response =
            await supabase.auth.signUp(password: password, email: email);
        if (response.user == null) {
          return 2;
        } else {
          await supabase.from('user_info').insert({
            'username': username,
            'email': email,
          });
          return 3;
        }
      } else {
        return 1;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<int> signIn() async {
    try {
      EmailValidatorFlutter emailValidatorFlutter = EmailValidatorFlutter();
      String userOrEmail = email;
      if (!emailValidatorFlutter.validateEmail(email)) {
        final data = await supabase
            .from('user_info')
            .select('email')
            .eq('username', email);
        userOrEmail = data.elementAt(0)['email'];
      }

      final AuthResponse response = await supabase.auth.signInWithPassword(
        password: password,
        email: userOrEmail,
      );

      if (response.user == null) {
        return 2;
      } else {
        return 1;
      }
    } catch (e) {
      return 0;
    }
  }
}
