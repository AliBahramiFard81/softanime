part of 'background_image_cubit.dart';

@immutable
sealed class BackgroundImageState {}

final class BackgroundImageInitial extends BackgroundImageState {}

final class BackgroundImageChanged extends BackgroundImageState {
  final String image;
  BackgroundImageChanged({required this.image});
}
