import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/bloc/auth_bloc.dart';
import 'package:main/cubit/background_image_cubit.dart';
import 'package:main/pages/home_page.dart';
import 'package:main/pages/login_page.dart';
import 'package:main/widgets/background_image.dart';
import 'package:sizer/sizer.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late PageController pageController;
  late Timer timer;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    timer.cancel();
    super.dispose();
  }

  int index = -1;
  void changeImage(BackgroundImageCubit backgroundImageCubit) {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      index++;
      if (index == 12) {
        index = 0;
      }
      backgroundImageCubit.changeBackground(index);
      animationController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final backgroundImageCubit = BlocProvider.of<BackgroundImageCubit>(context);
    backgroundImageCubit.changeBackground(0);
    changeImage(backgroundImageCubit);
    context.read<AuthBloc>().add(AutoLogin());
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is NoUserFound) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            }
            if (state is AuthSuccess) {
              context.read<AnimeBloc>().add(GetHomePage());
            }
            if (state is AuthFailed) {
              print('failed');
            }
          },
        ),
        BlocListener<AnimeBloc, AnimeState>(
          listener: (context, state) {
            if (state is AnimeHomeSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
            if (state is AnimeHomeFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
              context.read<AnimeBloc>().add(GetHomePage());
            }
          },
        )
      ],
      child: Scaffold(
        body: BlocBuilder<BackgroundImageCubit, BackgroundImageState>(
          builder: (context, state) {
            if (state is BackgroundImageChanged) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      BackgroundImage(
                        image: state.image,
                      ),
                      FadeTransition(
                        opacity: animationController,
                        child: BackgroundImage(
                          image: state.image,
                        ),
                      ),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
