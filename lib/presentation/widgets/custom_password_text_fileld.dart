import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pp/core/functions.dart';

import '../../bussiness_logic/cubit/global_cubit.dart';
import 'custom_text_form_field.dart';

class CustomPasswordTextField extends StatelessWidget {
  const CustomPasswordTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCubit, GlobalState>(
      builder: (context, state) {
        var cubit = GlobalCubit.get(context);
        return CustomTextFormField(
          controller: controller,
          obscureText: cubit.isVisible,
          textInputType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          hintText: "*************",
          labelText: "Password",
          validate: (value) {
            if (value.isEmpty) {
              return "Please Enter Your Password";
            } else if (isPassword(value) == false) {
              return "Password Should have alphabet and numbers with minimum length of 8 chars";
            }
            return null;
          },
          widget: InkWell(
            child: cubit.isVisible == true
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
            onTap: () {
              cubit.changeVisible();
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
