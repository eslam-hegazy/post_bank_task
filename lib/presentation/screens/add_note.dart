import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_pp/bussiness_logic/cubit/global_cubit.dart';
import 'package:task_pp/presentation/widgets/custom_drop_text_list.dart';
import 'package:task_pp/presentation/widgets/custom_text_form_field.dart';
import 'package:task_pp/presentation/widgets/custom_toast.dart';

class AddNote extends StatelessWidget {
  AddNote({
    Key? key,
  }) : super(key: key);
  var noteController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String dropListValue = "null";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
        actions: [
          BlocConsumer<GlobalCubit, GlobalState>(
            builder: (context, state) {
              var cubit = GlobalCubit.get(context);
              return IconButton(
                onPressed: () {
                  String userId = cubit.users.indexOf(dropListValue).toString();
                  if (formKey.currentState!.validate()) {
                    cubit.addNote(
                      text: noteController.text,
                      userId: userId,
                      placeDateTime: DateTime.now().toString(),
                    );
                    print(userId);
                  }
                },
                icon: state is LoadingInsertNoteState
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(Icons.save),
              );
            },
            listener: (context, state) {
              if (state is SuccessfulInsertNoteState) {
                Navigator.pop(context);
                customToast(state.message, Colors.grey);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: noteController,
                obscureText: false,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
                hintText: "",
                labelText: "Note",
                maxLines: 5,
                validate: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Your Note";
                  }
                  return null;
                },
              ),
              CustomDropTextField(
                listData: GlobalCubit.get(context).users,
                labelText: "Assign To User",
                onChanged: (value) {
                  dropListValue = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
