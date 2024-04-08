// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/anime_bloc.dart';
import 'package:main/bloc/auth_bloc.dart';
import 'package:main/cubit/background_image_cubit.dart';
import 'package:main/cubit/login_cubit.dart';
import 'package:main/pages/home_page.dart';
import 'package:main/widgets/background_image.dart';
import 'package:main/widgets/sign_in_view.dart';
import 'package:main/widgets/sign_up_view.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late List<TextEditingController> textEditingController;
  late AnimationController animationController;
  late PageController pageController;
  late Timer timer;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    textEditingController = List.generate(
      2,
      (index) => TextEditingController(),
    );
    pageController = PageController();
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthFailed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
            if (state is AuthSuccess) {
              context.read<AnimeBloc>().add(GetHomePage());
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
        ),
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
                      const BackgroundImage(
                        image: 'lib/assets/images/jujutsu.png',
                      ),
                      FadeTransition(
                        opacity: animationController,
                        child: BackgroundImage(
                          image: state.image,
                        ),
                      ),
                      BlocBuilder<LoginCubit, LoginState>(
                        builder: (context, state) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 104, 104, 104)
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.2.w,
                                color: Colors.grey,
                              ),
                            ),
                            height: state is PageViewChanged
                                ? 40.h + state.index * 10.h
                                : 40.h,
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            margin: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 20.w,
                            ),
                            child: PageView(
                              controller: pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              onPageChanged: (value) {
                                final loginViewCubit =
                                    BlocProvider.of<LoginCubit>(context);
                                loginViewCubit.onPageViewChanged(value);
                              },
                              children: [
                                SignInView(pageController: pageController),
                                SignUpView(pageController: pageController),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const BackgroundImage(
                image: 'lib/assets/images/jujutsu.png',
              );
            }
          },
        ),
      ),
    );
  }
}
