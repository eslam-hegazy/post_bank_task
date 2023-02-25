import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);
  final String title;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.h),
      child: MaterialButton(
        elevation: 4,
        minWidth: double.infinity,
        color: Colors.deepPurple,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.h),
          borderSide: const BorderSide(
            color: Colors.deepPurple,
          ),
        ),
        onPressed: press,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
