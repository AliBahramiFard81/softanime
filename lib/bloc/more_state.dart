part of 'more_bloc.dart';

@immutable
sealed class MoreState {}

final class MoreInitial extends MoreState {}

final class MoreLoading extends MoreState {}

final class MoreFailed extends MoreState {
  final String error;
  MoreFailed({required this.error});
}

final class MoreSuccess extends MoreState {
  final List more;
  MoreSuccess({required this.more});
}
