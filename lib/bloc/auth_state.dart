part of 'auth_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthInitial extends AuthenticationState {}

final class AuthSuccess extends AuthenticationState {}

final class AuthFailed extends AuthenticationState {
  final String error;
  AuthFailed({required this.error});
}

final class NoUserFound extends AuthenticationState {}

final class AuthLoading extends AuthenticationState {}
