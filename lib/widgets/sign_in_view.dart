import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/auth_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/widgets/custom_text_field.dart';
import 'package:main/widgets/gradient_button.dart';

class SignInView extends StatefulWidget {
  final PageController pageController;
  const SignInView({
    super.key,
    required this.pageController,
  });

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late List<TextEditingController> textEditingController;
  @override
  void initState() {
    textEditingController = List.generate(
      2,
      (index) => TextEditingController(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Sign in',
          style: textStyle5Color,
        ),
        CustomTextField(
          textEditingController: textEditingController[0],
          hintText: 'Email or username',
          isObscure: false,
        ),
        CustomTextField(
          textEditingController: textEditingController[1],
          hintText: 'Password',
          isObscure: true,
        ),
        BlocBuilder<AuthBloc, AuthenticationState>(
          builder: (context, state) {
            return GradientButton(
                text: 'Sign in',
                onPressed: state is AuthLoading || state is AuthSuccess
                    ? () {}
                    : () {
                        context.read<AuthBloc>().add(UserLogin(
                              email: textEditingController[0].text,
                              password: textEditingController[1].text,
                            ));
                      });
          },
        ),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<AuthBloc, AuthenticationState>(
            builder: (context, state) {
              return TextButton(
                style: TextButton.styleFrom(
                  fixedSize: const Size(395, 55),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: state is AuthLoading || state is AuthSuccess
                    ? () {}
                    : () {
                        widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Easing.legacy,
                        );
                      },
                child: Text(
                  'Sign up',
                  style: textStyle7,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
