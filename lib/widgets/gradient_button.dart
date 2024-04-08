import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(187, 63, 221, 1),
            Color.fromRGBO(251, 109, 169, 1),
            Color.fromRGBO(255, 159, 124, 1),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(395, 55),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: BlocBuilder<AuthBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthLoading || state is AuthSuccess) {
              return const CircularProgressIndicator();
            } else {
              return Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                  fontFamily: 'Fonstars',
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
