import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_state.dart';

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit() : super(CarouselInitial());

  void getIndex(int index) {
    return emit(CarouselIndex(index: index));
  }

  void carouselProgressReset() {
    return emit(CarouselProgressReset());
  }

  void carouselProgressStart() {
    emit(CarouselProgressStart());
    carouselProgressValue();
    return;
  }

  void carouselProgressValue() async {
    for (int i = 0; i <= 1000; i++) {
      if (state is CarouselProgressReset) {
        return emit(CarouselProgressValue(value: 0));
      }
      emit(CarouselProgressValue(value: i / 1000));
      await Future.delayed(const Duration(milliseconds: 1));
    }
  }
}
