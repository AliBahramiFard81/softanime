import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'background_image_state.dart';

class BackgroundImageCubit extends Cubit<BackgroundImageState> {
  BackgroundImageCubit() : super(BackgroundImageInitial());
  List<String> images = [
    'lib/assets/images/chain.png',
    'lib/assets/images/clover.png',
    'lib/assets/images/demon.png',
    'lib/assets/images/dragon..png',
    'lib/assets/images/hero.png',
    'lib/assets/images/hunter.png',
    'lib/assets/images/jujutsu.png',
    'lib/assets/images/naratu.png',
    'lib/assets/images/one_piece.png',
    'lib/assets/images/silent.png',
    'lib/assets/images/spy.png',
    'lib/assets/images/tokyo.png',
  ];
  void changeBackground(int index) {
    return emit(BackgroundImageChanged(image: images[index]));
  }
}
