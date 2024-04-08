part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class PageViewChanged extends LoginState {
  final int index;
  PageViewChanged({required this.index});
}
