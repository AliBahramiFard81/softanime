import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/auth_bloc.dart';
import 'package:main/common/font_styles.dart';
import 'package:main/widgets/custom_text_field.dart';
import 'package:main/widgets/gradient_button.dart';

class SignUpView extends StatefulWidget {
  final PageController pageController;
  const SignUpView({
    super.key,
    required this.pageController,
  });

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  late List<TextEditingController> textEditingController;
  @override
  void initState() {
    textEditingController = List.generate(
      3,
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
          'Sign up',
          style: textStyle5Color,
        ),
        CustomTextField(
          textEditingController: textEditingController[0],
          hintText: 'Username',
          isObscure: false,
        ),
        CustomTextField(
          textEditingController: textEditingController[1],
          hintText: 'Email',
          isObscure: false,
        ),
        CustomTextField(
          textEditingController: textEditingController[2],
          hintText: 'Password',
          isObscure: true,
        ),
        BlocBuilder<AuthBloc, AuthenticationState>(
          builder: (context, state) {
            return GradientButton(
                text: 'Sign up',
                onPressed: state is AuthLoading || state is AuthSuccess
                    ? () {}
                    : () {
                        context.read<AuthBloc>().add(UserRegister(
                              username: textEditingController[0].text,
                              email: textEditingController[1].text,
                              password: textEditingController[2].text,
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
                        widget.pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Easing.legacy,
                        );
                      },
                child: Text(
                  'Sign in',
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
