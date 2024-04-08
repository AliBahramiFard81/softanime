part of 'carousel_cubit.dart';

@immutable
sealed class CarouselState {}

final class CarouselInitial extends CarouselState {}

final class CarouselIndex extends CarouselState {
  final int index;
  CarouselIndex({required this.index});
}

final class CarouselProgressValue extends CarouselState {
  final double value;
  CarouselProgressValue({required this.value});
}

final class CarouselProgressReset extends CarouselState {}

final class CarouselProgressStart extends CarouselState {}
