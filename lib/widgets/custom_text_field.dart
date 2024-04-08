import 'package:flutter/material.dart';
import 'package:main/common/colors.dart';
import 'package:main/common/font_styles.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final bool isObscure;
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      style: TextStyle(
        overflow: TextOverflow.fade,
        color: Colors.white,
        fontSize: 12.sp,
      ),
      obscureText: isObscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: textStyle6Color,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 0.5.w,
            color: customPink,
          ),
        ),
      ),
    );
  }
}
