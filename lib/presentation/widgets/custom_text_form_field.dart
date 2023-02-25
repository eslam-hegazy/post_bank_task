import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.textInputType,
    required this.textInputAction,
    required this.hintText,
    required this.labelText,
    required this.validate,
    this.widget,
    this.maxLines,
  }) : super(key: key);
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final String hintText;
  final String labelText;
  final FormFieldValidator validate;
  final Widget? widget;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        maxLines: maxLines ?? 1,
        textAlignVertical: TextAlignVertical.top,
        textInputAction: textInputAction,
        validator: validate,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          suffixIcon: widget,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.w),
          ),
        ),
      ),
    );
  }
}
