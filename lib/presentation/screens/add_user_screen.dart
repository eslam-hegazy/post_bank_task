import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_pp/bussiness_logic/cubit/global_cubit.dart';
import 'package:task_pp/core/functions.dart';
import 'package:task_pp/core/strings.dart';
import 'package:task_pp/presentation/widgets/custom_button.dart';
import 'package:task_pp/presentation/widgets/custom_drop_text_list.dart';
import 'package:task_pp/presentation/widgets/custom_password_text_fileld.dart';
import 'package:task_pp/presentation/widgets/custom_text_form_field.dart';
import 'package:task_pp/presentation/widgets/custom_toast.dart';

class AddUserScreen extends StatelessWidget {
  AddUserScreen({super.key});
  var userController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  String? dropListValue;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 5.h),
                CircleAvatar(
                  radius: 8.h,
                  backgroundImage: const NetworkImage(BASE_IMAGE_URL),
                ),
                SizedBox(height: 1.5.h),
                const Text(
                  "Select Image",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                CustomTextFormField(
                  controller: userController,
                  obscureText: false,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  hintText: "Enter Your Name",
                  labelText: "User Name",
                  validate: (value) {
                    if (value.isEmpty) {
                      return "Please Enter UserName";
                    }
                    return null;
                  },
                ),
                CustomPasswordTextField(
                  controller: passwordController,
                ),
                CustomTextFormField(
                  controller: emailController,
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  hintText: "Enter Your Email",
                  labelText: "Email",
                  validate: (value) {
                    if (value.isEmpty) {
                      return "Please Enter Your Email";
                    } else if (isEmail(value) == false) {
                      return "Incorrect Email";
                    }
                    return null;
                  },
                ),
                CustomDropTextField(
                  listData: GlobalCubit.get(context).intrests,
                  labelText: "Interest",
                  onChanged: (value) {
                    dropListValue = value;
                  },
                ),
                BlocConsumer<GlobalCubit, GlobalState>(
                  builder: (context, state) {
                    var cubit = GlobalCubit.get(context);
                    return state is LoadingInsertUserState
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            title: "SAVE",
                            press: () {
                              if (formKey.currentState!.validate()) {
                                cubit.insertUser(
                                    userName: userController.text,
                                    password: passwordController.text,
                                    email: emailController.text);
                              }
                            },
                          );
                  },
                  listener: (context, state) {
                    if (state is SuccessfulInsertUserState) {
                      customToast(state.message, Colors.blue);
                    }
                    if (state is ErrorInsertUserState) {
                      customToast(state.message, Colors.red);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
