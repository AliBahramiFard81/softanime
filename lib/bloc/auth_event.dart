part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class UserLogin extends AuthEvent {
  final String email;
  final String password;
  UserLogin({
    required this.email,
    required this.password,
  });
}

final class UserRegister extends AuthEvent {
  final String username;
  final String email;
  final String password;
  UserRegister({
    this.username = '',
    required this.email,
    required this.password,
  });
}

final class AutoLogin extends AuthEvent {}
